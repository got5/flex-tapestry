package org.flexmvc.metadata
{
  import flash.utils.describeType;
  
  import mx.core.UIComponent;

  public class MetadataManager
  {
    /** Manages bean (controllers, services...) metadatas. <code>pView</code> 
     * parameter is mandatory if <code>pBean</code> is a controller. */ 
    public static function manageBean(pBean:Object, pView:UIComponent = null):void {
      var classInfo:XML = describeType(pBean);
      
      manageBeanVariables(classInfo..variable, pBean, pView);
      manageBeanAccessors(classInfo..accessor, pBean, pView);
      manageBeanMethods(classInfo..method, pBean, pView);
    }
    
    /** Manages pBean variables metadatas. */
    private static function manageBeanVariables(pVariables:XMLList, pBean:Object, pView:UIComponent):void {
      for each (var variable:XML in pVariables) {
        for each (var metadata:XML in variable.metadata) {
          switch (metadata.@name.toString()) {
            case MetadataConstants.INJECT:
              InjectManager.manageInject(pBean, variable.@name, variable.@type);
              break;
            case MetadataConstants.SYMBOL:
              InjectManager.manageSymbol(pBean, variable.@name);
              break;
            case MetadataConstants.PERSIST:
              PersistManager.managePersist(pBean, variable.@name, variable.@type, pView);
              break;
            case MetadataConstants.COMPONENT:
              InjectManager.manageComponent(pBean, variable.@name, variable.@type, pView);
              break;
            case MetadataConstants.COMPONENT_PROPERTY:
              InjectManager.manageComponentProperty(pBean, variable.@name, variable.@type, pView, metadata);
              break;
            default:
              break;
          }
        }
      }
    }
    
    /** Manages pBean variables accessors. */
    private static function manageBeanAccessors(pAccessors:XMLList, pBean:Object, pView:UIComponent):void {
      for each (var accessor:XML in pAccessors) {
        // Do not get the property value if it is write only.
        if (accessor.@access == 'writeonly') {
          trace("Property " + accessor.@name + " (" + accessor.@type +")\n");
        }
        else {
          trace("Property " + accessor.@name + "=" + pBean[accessor.@name] +  " (" + accessor.@type +")\n");
        }
      } 
    }
    
    /** Manages pBean variables methods. */
    private static function manageBeanMethods(pMethods:XMLList, pBean:Object, pView:UIComponent):void
    {
      for each (var method:XML in pMethods) {
        //trace("Method " + method.@name + "():" + method.@returnType + "\n");
        EventHandlerManager.manageFromXML(method, pBean, pView);
      }
    }
  }
}