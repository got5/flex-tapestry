package org.flexmvc.core
{
  import org.flexmvc.utils.HashMap;
  
  /** Base module. Its goal is to be overriden by the application module. */
  public class BaseModule
  {
    /** Used to import the CoreManager class... */
    private static var _coreImport:ApplicationManager;
    
    /** Returns an array with all the view classes of the application. */
    public function get views():Array /* of Class */ {
      throw new ModuleError("The views accessor needs to be overriden in your application module.");
    }
    
    /** Returns an array with all the controller classes of the application. */
    public function get controllers():Array {
      throw new ModuleError("The controllers accessor needs to be overriden in your application module.");
    }
    
    /** Returns an array of submodules to load. */
    public function get subModules():Array /* of BaseModule */ {
      //To override if needed.
      return null;
    }
    
    /** Used to configure the values of the application constants. See {SymbolConstants}. */
    public function contributeApplicationDefaults(pConstantsMap:HashMap):void {
      //To override if needed
    }
    
    /** Used to store the services. The key is the service interface, the value is the implementation. */
    public function bindServices(pServicesMap:HashMap):void {
      //To override if needed
    }
  }
}