package org.flexmvc.view
{
  import flash.utils.describeType;
  
  import mx.core.UIComponent;
  
  import org.flexmvc.core.ApplicationManager;
  import org.flexmvc.metadata.EventHandlerManager;
  import org.flexmvc.metadata.InjectManager;
  import org.flexmvc.metadata.MetadataConstants;
  import org.flexmvc.utils.ObjectUtils;
  
  /** View manager. Used to handle views and controllers life cycle. */
  public class ViewManager
  {
    /** Inits a view and its controller. */
    public static function activateView(pView:IView):void {
      var viewClass:Class = ObjectUtils.getClass(pView);
      var controllerClass:Class = ApplicationManager.getViewController(viewClass);
      if (controllerClass != null) {
        //The controller has a no-arg constructor (tested at startup).
        var controller:Object = new controllerClass();
        if (controller) {
          manageController(controller, pView as UIComponent);
        }
      }
    }
    
    /** Manages controller metadatas. */ 
    private static function manageController(pController:Object, pView:UIComponent):void {
      var classInfo:XML = describeType(pController);
      
      manageControllerVariables(classInfo..variable, pController, pView);
      manageControllerAccessors(classInfo..accessor, pController, pView);
      manageControllerMethods(classInfo..method, pController, pView);
    }
    
    /** Manages pController variables metadatas. */
    private static function manageControllerVariables(pVariables:XMLList, pController:Object, pView:UIComponent):void {
      for each (var variable:XML in pVariables) {
        for each (var metadata:XML in variable.metadata) {
          switch (metadata.@name.toString()) {
            case MetadataConstants.INJECT:
              InjectManager.manageInject(pController, variable.@name, variable.@type);
              break;
            case MetadataConstants.SYMBOL:
              InjectManager.manageSymbol(pController, variable.@name);
              break;
            case MetadataConstants.COMPONENT:
              InjectManager.manageComponent(pController, variable.@name, variable.@type, pView);
              break;
            case MetadataConstants.COMPONENT_PROPERTY:
              InjectManager.manageComponentProperty(pController, variable.@name, variable.@type, pView, metadata);
              break;
            default:
              break;
          }
        }
      }
    }
    
    /** Manages pController variables accessors. */
    private static function manageControllerAccessors(pAccessors:XMLList, pController:Object, pView:UIComponent):void {
      for each (var accessor:XML in pAccessors) {
        // Do not get the property value if it is write only.
        if (accessor.@access == 'writeonly') {
          trace("Property " + accessor.@name + " (" + accessor.@type +")\n");
        }
        else {
          trace("Property " + accessor.@name + "=" + pController[accessor.@name] +  " (" + accessor.@type +")\n");
        }
      } 
    }
    
    /** Manages pController variables methods. */
    private static function manageControllerMethods(pMethods:XMLList, pController:Object, pView:UIComponent):void
    {
      for each (var method:XML in pMethods) {
        //trace("Method " + method.@name + "():" + method.@returnType + "\n");
        EventHandlerManager.manageFromXML(method, pController, pView);
      }
    }
    
    /** Deactivate the view and its controller. */
    public static function deactivateView(pView:IView):void {
      
    }
  }
}