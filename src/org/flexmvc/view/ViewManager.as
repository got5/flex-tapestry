package org.flexmvc.view
{
  
  import mx.core.UIComponent;
  
  import org.flexmvc.core.ApplicationManager;
  import org.flexmvc.metadata.MetadataManager;
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
          MetadataManager.manageBean(controller, pView as UIComponent);
        }
      }
    }
    
    /** Deactivate the view and its controller. */
    public static function deactivateView(pView:IView):void {
      
    }
  }
}