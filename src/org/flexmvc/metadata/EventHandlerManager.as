package org.flexmvc.metadata
{
  import flash.events.Event;
  
  import mx.core.UIComponent;
  import mx.events.FlexEvent;
  
  import org.flexmvc.core.ApplicationManager;
  import org.flexmvc.utils.ContainerUtils;
  import org.flexmvc.view.DestinationViewVO;
  import org.flexmvc.view.IView;
  
  import spark.events.ViewNavigatorEvent;

  /** Manages function custom annotations, mainly used to define the function as an event handler. */
  public class EventHandlerManager
  {
    /** component parameter for OnEvent annotation. */
    private static const ON_EVENT_COMPONENT:String = 'component';
    
    /** value parameter for OnEvent annotation. */
    private static const ON_EVENT_VALUE:String = 'value';
    
    /** Naming convention for an event handler : onEventFromComponent */
    private static const ON:String = 'on';
    
    /** Naming convention for an event handler : onEventFromComponent */
    private static const FROM:String = 'From';
    
    /** Naming convention for an event handler : onSetupRender */
    private static const SETUP_RENDER:String = 'SetupRender';
    
    /** Naming convention for an event handler : onSetupRender */
    private static const CLEANUP_RENDER:String = 'CleanupRender';
    
    /** Manages method annotations, from the method XML description (using describeType for example), and with the method object. */
    public static function manageFromXML(pMethod:XML, pController:Object, pComponent:UIComponent):void {
      if (pMethod && pController) {
        var methodName:String = pMethod.@name.toString();
        
        //Flag to know if naming conventions need to be checked after.
        //TODO : boolean for type of metadata?
        var bIsEventHandled:Boolean = false;
        
        //Metadatas on the function.
        for each (var metadata:XML in pMethod.metadata) {
          switch (metadata.@name.toString()) {
            //SetupRender annotation case.
            case MetadataConstants.SETUP_RENDER:
              manageSetupRender(methodName, pController, pComponent);
              bIsEventHandled = true;
              break;
            //CleanupRender annotation case.
            case MetadataConstants.CLEANUP_RENDER:
              manageCleanupRender(methodName, pController, pComponent);
              bIsEventHandled = true;
              break;
            //OnEvent annotation.
            case MetadataConstants.ON_EVENT:
              var dispatcher:String;
              var event:String;
              for each (var arg:XML in metadata.arg) {
                if (arg.@key.toString() == ON_EVENT_COMPONENT) {
                  dispatcher = arg.@value.toString()
                }
                if (arg.@key.toString() == ON_EVENT_VALUE) {
                  event = arg.@value.toString()
                }
              }
              if (!dispatcher) {
                throw new MetadataError("The parameter 'component' (refers to the listened component) is mandatory when using OnEvent annotation.");
              }
              if (!event) {
                throw new MetadataError("The parameter 'value' (refers to the listened event) is mandatory when using OnEvent annotation.");
              }
              manageOnEvent(methodName, pController, pComponent, dispatcher, event);
              bIsEventHandled = true;
              break;
            default:
              break;
          }
        }
        
        //Function naming conventions
        if (!bIsEventHandled && methodName.indexOf(ON) == 0) {
          var indexFrom:int = methodName.indexOf(FROM);
          if (methodName.indexOf(SETUP_RENDER) > 0) {
            manageSetupRender(methodName, pController, pComponent);
          } else if (methodName.indexOf(CLEANUP_RENDER) > 0) {
            manageCleanupRender(methodName, pController, pComponent);
          } else if (indexFrom > 0) { 
            var eventType:String = methodName.substring(ON.length, indexFrom).toLocaleLowerCase();
            var dispatcherId:String = methodName.substring(indexFrom + FROM.length);
            manageOnEvent(methodName, pController, pComponent, dispatcherId, eventType);
          }
        }
      }
    }
    
    /** Manages SetupRender metadata on a function. */
    public static function manageSetupRender(pFunctionName:String, pController:Object, pComponent:UIComponent):void {
      //Already initialized: we call directly the function.
      if (pComponent.initialized) {
        pController[pFunctionName]();
      } else {
        pComponent.addEventListener(FlexEvent.CREATION_COMPLETE, 
          function(pEvent:FlexEvent):void {
            pController[pFunctionName]();
          });
      }
    }
    
    /** Manages CleanupRender metadata on a function. */
    public static function manageCleanupRender(pFunctionName:String, pController:Object, pComponent:UIComponent):void {
      pComponent.addEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, 
        function(pEvent:ViewNavigatorEvent):void {
          pController[pFunctionName]();
        });
    }
    
    /** Manages OnEvent metadata on a function. */
    public static function manageOnEvent(pFunctionName:String, pController:Object, pComponent:UIComponent, pEventDispatcherId:String, pEvent:String):void {
      var eventDispatcher:UIComponent = ContainerUtils.getChildById(pComponent, pEventDispatcherId);
      if (eventDispatcher) {
        eventDispatcher.addEventListener(pEvent, function(pEvent:Event):void { 
          var handlerResult:Object = pController[pFunctionName]();
          handleResult(handlerResult);
        });
      }
    }
    
    /** Handles function results (to redirect on another view if needed). */
    private static function handleResult(pResult:Object):void {
      if (pResult is Class) {
        ApplicationManager.application.navigator.pushView(pResult as Class);
      } else if (pResult is DestinationViewVO) {
        var destination:DestinationViewVO = pResult as DestinationViewVO;
        ApplicationManager.application.navigator.pushView(destination.viewClass, destination.data, destination.context, destination.transition);
      } else if (pResult != null) {
        throw new MetadataError("Unhandled return result : " + pResult);
      }
    }
  }
}