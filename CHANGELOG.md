# v2.3.2
* Hot fix. incorrect work cache for specific case.

# v2.3.1
* Fix bug. Supported recursive resolve ViewControllers.

# v2.3.0
* Fix bug (issue98) into methods initial(useStoryboard:identifier:) and initial(nib:).


# v2.2.0
* Fix modularity bug - reorganization internal work with modularity and access levels
* Supported settings for set default behavior
* Improve injection into ViewControllers. Now app crash if found injections for VC but can’t injection into VC

# v2.1.5, v2.1.6
* Fix modularity access level for complex dependencies

# v2.1.4
* Move logger into default subspec and change realization
* Fix 'as' short style operation - add @discardableResult
* Improve intersectionNames error - now this error contains only incorrect types
* Fix scan components for Modular - now scan component is an public component

# v2.1.2, v2.1.3
* Add tags

# v2.1.0, v2.1.1
* Add logs
* Removed supported errors
* Simplified error names
* Improved separate project for `module`
* Separation `injection` method on: `injection(.manual)`, `injection(.optional)`, `injection`, `postInit`

# v2.0.0
* Add documentation for migration
* A full update documentation
* Remove Lazy
* Remove DynamicAssembly. Now there are late binding
* Rename DIModule -> DIComponent and DIAssembly -> DIModule
* Support area of vision for the components using modules
* Add weak single
* Add error description
* Greatly improve old syntax
* Separate library on modules: `Core`, `Description`, `Component`, `Module`, `Storyboard`, `Scan`, `RuntimeArgs`
* Support auto inject properties for Obj-C types
* Much more


# v1.3.1
* Support Lazy `DILazy`
* Add documentation for lazy
* Improved typing - now `DIType` it's `Any.Type` for a place `Any`

# v1.3.0
* Update documentation
* Update README
* Remove lifetime: .perRequest
* Change arrangement works with ViewControllers
* Fix critical bug (issue-69): App Crash if call DIStoryboard get ViewController methods after short period of time
* Write Test by issue-69

# v1.2.0
* Update documentation
* Added base types: DIType, DIMethodSignature, DIComponent
* Improved DIError - changed names, and added additional parameters
* Change lifetime syntax - now it's method `lifetime(enum)`
* Fix scan bug: not supported recursive check superclass.
* Improved internal code style

# v1.1.1
* Change scan syntax: replace ScannedModule and ScannedAssembly to Scanned + Module and Scanned + Assembly
* Update documentation page scan

# v1.1.0
* Added Scan (ScannedModule, ScannedAssembly, ScanModule, ScanAssembly)
* Update documentation - added scan page

# v1.0.0
* Supported macOS
* Added tvOS

# v0.9.9
* Added short registration syntax for types
* Added short registration syntax for UIViewController
* Renamed resolve functions with parameter 'Name:' to 'name:'
* Added tests

# v0.9.8
* Supported Carthage
* Added Travis
* Supported SwiftPM
