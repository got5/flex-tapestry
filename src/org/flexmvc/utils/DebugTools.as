package org.flexmvc.utils
{
  public class DebugTools
  {
    public static function getCalledClassesStack():Vector.<Class> {
      var error:Error = new Error();
      var stackTrace:String = error.getStackTrace();
      
      return null;
    }
  }
}