
Force Package Fail Task (SSIS)
==============================

Problem: You are in a Data Flow and on a specific condition you want the Data Flow or the whole package to fail. The solution is to use a script component and use the following C# code:

    public override void Input0_ProcessInputRow(Input0Buffer Row)
    {
        bool pbCancel = false;
        this.ComponentMetaData.FireError(10, "MyFailingPackage", "Custom error message", "", 0, out pbCancel);
    }

The parameters of the method FireError are...

    FireError(
        int ErrorCode,
        string SubComponent,
        string Description,
        string HelpFile,
        int HelpContext,
        out bool pbCancel
    );

