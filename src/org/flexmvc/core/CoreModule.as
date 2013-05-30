package org.flexmvc.core
{
  import org.flexmvc.constants.SymbolConstants;
  import org.flexmvc.services.ISQLService;
  import org.flexmvc.services.SQLService;
  import org.flexmvc.utils.HashMap;

  /** Library module. Is loaded first, and sets initial configuration for the application. */
  public class CoreModule extends BaseModule
  {
    /** Returns an array with all the view classes of the application. */
    override public function get views():Array /* of Class */ {
      return null;
    }
    
    /** Returns an array with all the controller classes of the application. */
    override public function get controllers():Array {
      return null;
    }
    
    /** Sets the default values for all application constants. */
    override public function contributeApplicationDefaults(pConstantsMap:HashMap):void {
      pConstantsMap.put(SymbolConstants.PRODUCTION_MODE, false);
    }
    
    /** Used to store the services. The key is the service interface, the value is the implementation. */
    override public function bindServices(pServicesMap:HashMap):void {
      pServicesMap.put(ISQLService, SQLService);
    }
  }
}