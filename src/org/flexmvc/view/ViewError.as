package org.flexmvc.view
{
  public class ViewError extends Error
  {
    public static var CONTROLLER_NOT_OVERRIDDEN:String = 'controllerNotOverriden';
    
    public static var VIEW_NOT_FOUND:String = 'viewNotFound';
    
    public static var CONTROLLER_NOT_FOUND:String = 'controllerNotFound';
    
    public function ViewError(pMessage:String)
    {
      super(pMessage);
    }
  }
}