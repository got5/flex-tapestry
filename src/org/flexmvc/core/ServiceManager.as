package org.flexmvc.core
{
  import org.flexmvc.metadata.MetadataError;
  import org.flexmvc.utils.HashMap;

  public class ServiceManager
  {
    /** Services list. Keys are services interfaces, and values are implementations. */
    private static var _services:HashMap = new HashMap();
    
    /** Returns service implementation corresponding to interface pInterfaceClass. */
    public static function getService(pInterfaceClass:Class):Class {
      var serviceImplementation:Class = _services.getValue(pInterfaceClass);
      
      if (!serviceImplementation) {
        throw new MetadataError("No implementation found for service interface : '" + pInterfaceClass + "'.");
      }
      
      return serviceImplementation;
    }
    
    /** Registers services defined by the module pModule. */
    public static function registerModuleServices(pModule:BaseModule):void {
      if (pModule) {
        pModule.bindServices(_services);
      }
    }
  }
}