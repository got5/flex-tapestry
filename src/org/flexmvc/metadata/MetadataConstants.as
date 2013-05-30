package org.flexmvc.metadata
{
  /** Framework custom metadata */
  public class MetadataConstants
  {
    // Variables metadatas //
    
    /** Dependency injection */
    public static const INJECT:String = 'Inject';
    
    /** Used to inject SymbolConstants values in controller variables. */
    public static const SYMBOL:String = 'Symbol';
    
    /** Used to link a controller variable to a view component. */
    public static const COMPONENT:String = 'Component';
    
    /** Used to link a controller variable to a view component property value. */
    public static const COMPONENT_PROPERTY:String = 'ComponentProperty';
    
    /** Used to save a variable value during user navigation. */
    public static const PERSIST:String = 'Persist';
    
    // Functions metadatas //
    
    /** Event handler */
    public static const ON_EVENT:String = 'OnEvent';
    
    /** Function called on view initialization. */
    public static const SETUP_RENDER:String = 'SetupRender';
    
    /** Function called on view destruction. */
    public static const CLEANUP_RENDER:String = 'CleanupRender';
  }
}