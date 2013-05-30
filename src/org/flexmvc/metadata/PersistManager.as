package org.flexmvc.metadata
{
  import flash.events.Event;
  
  import mx.core.UIComponent;
  
  import spark.components.View;
  import spark.events.ViewNavigatorEvent;
  
  /** Manages Persist annotation on variables, to register their value. Used only in controllers. */
  public class PersistManager {
    
    /** Object which contains persisted values. */
    private static var _persistValues:Object = new Object();
    
    /** Handles Persist annotation on variable <code>pVariableName</code> of object <code>pController</code>. */
    public static function managePersist(pController:Object, pVariableName:String, pVariableType:String, pView:UIComponent):void {
      if (pController && pVariableName && pVariableType && pView is View) {
        //We set last variable value if there is one.
        if (_persistValues.hasOwnProperty(pVariableName)) {
          pController[pVariableName] = _persistValues[pVariableName];
        }
        
        //We save the value when the user quit the associated view.
        pView.addEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, function(pEvent:Event):void {
          _persistValues[pVariableName] = pController[pVariableName];
        }, false, 0, true);
      }
    }
  }
}