package org.flexmvc.view
{
  import flash.utils.describeType;
  
  import mx.events.FlexEvent;
  
  import org.flexmvc.utils.ObjectUtils;

  public class ViewController {
    private var _view:IView;
    
    public function get view():IView {
      return _view;
    }
    
    public function ViewController(pView:IView) {
      if (ObjectUtils.getClass(this) == ViewController) {
        throw new ViewError('ViewController class must be overriden.');
      }
      
      _view = pView;
      
      if (_view) {
        _view.addEventListener(FlexEvent.INITIALIZE, onViewInitialized, false, 0, true);
      }
    }
    
    private function onViewInitialized(pEvent:FlexEvent):void {
      _view.removeEventListener(FlexEvent.INITIALIZE, onViewInitialized);
      
      initViewController();
    }
    
    private function initViewController():void {
      var classInfo:XML = describeType(this);
      
      handleVariables(classInfo..variable);
      handleAccessors(classInfo..accessor);
      handleMethods(classInfo..method);
    }
    
    private function handleVariables(pVariables:XMLList):void {
      for each (var variable:XML in pVariables) {
        trace("Variable " + variable.@name + "=" + this[variable.@name] + " (" + variable.@type + ")\n");
      }
    }
    
    private function handleAccessors(pAccessors:XMLList):void {
      for each (var accessor:XML in pAccessors) {
        // Do not get the property value if it is write only.
        if (accessor.@access == 'writeonly') {
          trace("Property " + accessor.@name + " (" + accessor.@type +")\n");
        }
        else {
          trace("Property " + accessor.@name + "=" + this[accessor.@name] +  " (" + accessor.@type +")\n");
        }
      } 
    }
    
    private function handleMethods(pMethods:XMLList):void
    {
      for each (var method:XML in pMethods) {
        trace("Method " + method.@name + "():" + method.@returnType + "\n");
      }
    }
  }
}