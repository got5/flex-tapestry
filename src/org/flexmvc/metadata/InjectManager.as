package org.flexmvc.metadata
{
  import avmplus.getQualifiedClassName;
  
  import flash.utils.getDefinitionByName;
  
  import mx.core.UIComponent;
  
  import org.flexmvc.core.ApplicationManager;
  import org.flexmvc.utils.ContainerUtils;

  /** Manager which handles Inject annotation on variables. */
  public class InjectManager
  {
    /** Manages dependency injection on the variable pVariableName, of pVariableType type, and from object pBean. */
    public static function manageInject(pBean:Object, pVariableName:String, pVariableType:String):void {
      if (pBean && pVariableName && pVariableType) {
        
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
  }
}