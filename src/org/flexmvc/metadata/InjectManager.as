package org.flexmvc.metadata
{
  import avmplus.getQualifiedClassName;
  
  import flash.utils.getDefinitionByName;
  
  import mx.binding.utils.BindingUtils;
  import mx.core.UIComponent;
  
  import org.flexmvc.core.ApplicationManager;
  import org.flexmvc.core.ServiceManager;
  import org.flexmvc.utils.ContainerUtils;

  /** Manager which handles Inject annotation on variables. */
  public class InjectManager
  {
    /** <code>property</code> parameter for ComponentProperty annotation. */
    private static const PROPERTY:String = 'property';
    
    /** <code>component</code> parameter for ComponentProperty annotation. */
    private static const COMPONENT:String = 'component';
    
    /** value parameter for OnEvent annotation. */
    private static const ON_EVENT_VALUE:String = 'value';
    
    /** Separator between property name and component id for metadata Componentproperty. */
    private static const SEPARATOR:String = '_';
    
    /** Manages dependency injection on the variable pVariableName, of pVariableType type, and from object pBean. */
    public static function manageInject(pBean:Object, pVariableName:String, pVariableType:String):void {
      if (pBean && pVariableName && pVariableType) {
        var serviceInterfaceClass:Class = Class(getDefinitionByName(pVariableType));
        var serviceImplClass:Class = ServiceManager.getService(serviceInterfaceClass);
        if (serviceImplClass != null) {
          var serviceImplInstance:Object = new serviceImplClass();
          if (!(serviceImplInstance is serviceInterfaceClass)) {
            throw new MetadataError("Service implementation '" + serviceImplClass + "' does not implement interface '" + serviceInterfaceClass + "'.");
          }
          pBean[pVariableName] = serviceImplInstance;
        } else {
          throw new MetadataError("");
        }
      }
    }
    
    /** Injects a symbol constant value into a bean variable. */
    public static function manageSymbol(pBean:Object, pVariableName:String):void {
      if (pBean && pVariableName) {
        if (!ApplicationManager.hasSymbolConstant(pVariableName)) {
          throw new MetadataError("The class '" + pBean + "' is trying to inject a symbol constant named '" + pVariableName + "', but this constant does not exist.");
        }
        
        try {
          pBean[pVariableName] = ApplicationManager.getSymbolConstantValue(pVariableName);
        } catch (error:Error) {
          throw new MetadataError("Error trying to inject the value of the symbol constant '" + pVariableName + "'.");
        }
      }
    }
    
    /** Injects a symbol constant value into a bean variable. */
    public static function manageComponent(pBean:Object, pVariableName:String, pVariableType:String, pComponent:UIComponent):void {
      if (pBean && pVariableName && pComponent) {
        var viewComponent:UIComponent = ContainerUtils.getChildById(pComponent, pVariableName);
        if (viewComponent) {
          var variableClass:Class = Class(getDefinitionByName(pVariableType));
          if (viewComponent is variableClass) {
            pBean[pVariableName] = viewComponent;
          } else {
            throw new MetadataError("Component '" + pVariableName + "' has been injected in controller '" + pBean + "' from view '" + pComponent + "', but its type is '" + getQualifiedClassName(viewComponent) + "', not '" + pVariableType + "'.");
          }
        } else {
          throw new MetadataError("Component of id '" + pVariableName + "' does not exist in view '" + pComponent + "', but has been injected in controller '" + pBean + "'.");
        }
      }
    }
    
    public static function manageComponentProperty(pBean:Object, pVariableName:String, pVariableType:String, pComponent:UIComponent, pMetadata:XML):void {
      if (pBean && pVariableName && pVariableType && pComponent) {
        
        var propertyName:String;
        var componentName:String;
        
        if (pMetadata && pMetadata.arg && pMetadata.arg.length() > 0) {
          for each (var arg:XML in pMetadata.arg) {
            if (arg.@key.toString() == COMPONENT) {
              componentName = arg.@value.toString();
            }
            if (arg.@key.toString() == PROPERTY) {
              propertyName = arg.@value.toString();
            }
          }
        } else {
          //Naming convention
          var index:int = pVariableName.indexOf(SEPARATOR);
          propertyName = pVariableName.substring(0, index);
          componentName = pVariableName.substring(index + 1);
        }
        
        if (propertyName) {
          var viewComponent:UIComponent = (componentName && componentName.length > 0) ? ContainerUtils.getChildById(pComponent, componentName) : pComponent;
          if (viewComponent) {
            //Two-way binding.
            BindingUtils.bindProperty(pBean, pVariableName, viewComponent, propertyName);
          } else {
            throw new MetadataError("Component of id '" + pVariableName + "' does not exist in view '" + pComponent + "', but has been injected in controller '" + pBean + "'.");
          }
        } else {
          throw new MetadataError("Property name not found on variable '" + pVariableName + "' of controller '" + pBean + "'. This parameter is mandatory on 'ComponentProperty' annotation.");
        }
      }
    }
  }
}