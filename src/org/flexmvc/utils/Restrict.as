package org.flexmvc.utils
{
  import org.flexmvc.constants.SymbolConstants;
  import org.flexmvc.constants.SymbolConstantsValues;
  import org.flexmvc.core.ApplicationManager;

  /** Used to restrict use of functions, by package. */
  public class Restrict
  {
    /** Throws an error if the function which uses this has been called out of the framework. */
    public static function onlyToFramework():void {
      //Used only in development mode.
      if (ApplicationManager.getSymbolConstantValue(SymbolConstants.PRODUCTION_MODE) == SymbolConstantsValues.DEVELOPMENT) {
        var classes:Vector.<Class> = DebugTools.getCalledClassesStack();
      }
    }
  }
}