protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
{
    var dialog = new ConfirmCloseWindow();
    if (dialog.ShowDialog() != true)
    {
        e.Cancel = true;
    }
    base.OnClosing(e);
}