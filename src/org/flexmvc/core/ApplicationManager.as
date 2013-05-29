package org.flexmvc.core
{
  import flash.utils.getDefinitionByName;
  
  import mx.core.FlexGlobals;
  import mx.managers.ISystemManager;
  
  import avmplus.getQualifiedClassName;
  
  import org.flexmvc.constants.NamingConstants;
  import org.flexmvc.utils.HashMap;
  import org.flexmvc.utils.Restrict;
  import org.flexmvc.view.BaseApplication;
  import org.flexmvc.view.ViewError;
  
  /** Application core manager. Loads all modules, and managers the application. */
  [Mixin]
  public class ApplicationManager
  {
    /** Modules map. */
    private static var _modules:HashMap;
    
    /** Views map. */
    private static var _views:HashMap;
    
    /** Symbol constants values. See {SymbolConstants}. */
    private static var _symbolConstants:HashMap;
    
    /** Returns controller class linked to a view class. */
    public static function getViewController(pViewClass:Class):Class {
      Restrict.onlyToFramework();
      return _views.getValue(pViewClass);
    }
    
    /** Returns a value of a symbol constant registered in _symbolConstants map. */
    public static function getSymbolConstantValue(pKey:String):Object {
      return _symbolConstants.getValue(pKey);
    }
    
    /** Returns true if a symbol constant with key of value pKey exists. */
    public static function hasSymbolConstant(pKey:String):Boolean {
      return _symbolConstants.hasKey(pKey);
    }
    
    public static function get application():BaseApplication {
      return FlexGlobals.topLevelApplication as BaseApplication;
    }
    
    /** Called at the start of the application. Initializes all the app modules. */
    public static function init(pSystemManager:ISystemManager):void {
      initVariables();
      
      //Loads the core module.
      handleModule(CoreModule);
      
      //Get the module defined in the application and registers it.
      var infos:Object = pSystemManager.info();
      if (infos && infos.hasOwnProperty('moduleClass') && infos.moduleClass) {
        handleModule(Class(getDefinitionByName(infos.moduleClass)));
      }
    }
    
    /** Initializes all manager static variables. */
    private static function initVariables():void {
      _modules = new HashMap();
      _views = new HashMap();
      _symbolConstants = new HashMap();
    }
    
    /** Handles a new module (registers it, its views/controllers, and so on...). */
    private static function handleModule(pModuleClass:Class):void {
      if (pModuleClass != null) {
        //Module is registered in the manager.
        var module:BaseModule = registerModule(pModuleClass);
        
        //Module views and its controllers are registered.
        registerModuleViews(module); 
        
        //Sets symbol constants values.
        module.contributeApplicationDefaults(_symbolConstants);
        
        //Services registration.
        ServiceManager.registerModuleServices(module);
      }
    }
    
    /** Register a new module in the manager map. */
    private static function registerModule(pModuleClass:Class):BaseModule {
      if (pModuleClass != null && _modules.getValue(pModuleClass) == null) {
        var module:BaseModule;
        try {
          module = new pModuleClass() as BaseModule;
          _modules.put(pModuleClass, module);
        } catch (error:Error) {
          throw new ModuleError("Your module constructor (for class '" + pModuleClass + "') need to have no parameters.");
        }
        if (!module) {
          throw new ModuleError("Your module (of class '" + pModuleClass + "') does not override BaseModule class.");
        }
        return module;
      }
      return null;
    }
    
    /** Registers views and controllers. */
    private static function registerModuleViews(pModule:BaseModule):void {
      if (pModule && pModule.views) {
        var viewClassName:String;
        var controllerClassName:String;
        var controllerClass:Class;
        for each (var view:Class in pModule.views) {
          viewClassName = getQualifiedClassName(view);
          
          //Naming conventions: myViewVIEW and myControllerCONTROLLER
          controllerClassName = viewClassName.slice(0, viewClassName.lastIndexOf(NamingConstants.SUFFIX_VIEW)) + NamingConstants.SUFFIX_CONTROLLER;
          controllerClassName = controllerClassName.replace(NamingConstants.PACKAGE_VIEW, NamingConstants.PACKAGE_CONTROLLER);
          
          controllerClass = Class(getDefinitionByName(controllerClassName));
          if (controllerClass == null) {
            throw new ViewError("Controller class for view '" + viewClassName + "' has not been found. Verify you have the current class in your project : '" + controllerClassName + "'.");
          }
          
          _views.put(view, controllerClass);
        }
      }
    }
  }
}