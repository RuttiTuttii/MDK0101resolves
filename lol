### Решение лабораторной работы №36

#### **5.1 Создание недиалоговых окон**

**MainWindow.xaml:**
```xml
<Window x:Class="Lab5_1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Главное окно" Height="450" Width="800">
    <DockPanel>
        <Menu DockPanel.Dock="Top">
            <MenuItem Header="Файл">
                <MenuItem Header="Новое окно" Click="NewWindow_Click"/>
            </MenuItem>
        </Menu>
        <TextBox AcceptsReturn="True" VerticalScrollBarVisibility="Auto"/>
    </DockPanel>
</Window>
```

**MainWindow.xaml.cs:**
```csharp
private void NewWindow_Click(object sender, RoutedEventArgs e)
{
    var newWindow = new MainWindow();
    newWindow.Show();
}
```

---

#### **5.2 Экран-заставка**

1. Добавьте изображение (например, `splash.png`) в проект.
2. В свойствах изображения установите:
   - **Действие при сборке**: `SplashScreen`
   - **Копировать в выходной каталог**: `Копировать, если новее`

---

#### **5.3 Диалоговое окно подтверждения закрытия**

**ConfirmCloseWindow.xaml:**
```xml
<Window x:Class="Lab5_3.ConfirmCloseWindow"
        Title="Подтверждение" Height="150" Width="300"
        WindowStartupLocation="CenterScreen">
    <StackPanel Margin="10">
        <TextBlock Text="Вы уверены, что хотите закрыть окно?"/>
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,10">
            <Button Content="Да" IsDefault="True" Width="80" Margin="0,0,5,0" Click="Yes_Click"/>
            <Button Content="Нет" IsCancel="True" Width="80"/>
        </StackPanel>
    </StackPanel>
</Window>
```

**ConfirmCloseWindow.xaml.cs:**
```csharp
private void Yes_Click(object sender, RoutedEventArgs e)
{
    DialogResult = true;
}
```

**MainWindow.xaml.cs:**
```csharp
protected override void OnClosing(System.ComponentModel.CancelEventArgs e)
{
    var dialog = new ConfirmCloseWindow();
    if (dialog.ShowDialog() != true)
    {
        e.Cancel = true;
    }
    base.OnClosing(e);
}
```

---

#### **5.4 Разграничение прав доступа**

**LoginWindow.xaml:**
```xml
<Window x:Class="Lab5_4.LoginWindow"
        Title="Авторизация" Height="200" Width="300"
        WindowStartupLocation="CenterScreen" MinWidth="300" MinHeight="200">
    <StackPanel Margin="10">
        <TextBox x:Name="LoginBox" Margin="0,0,0,5"/>
        <PasswordBox x:Name="PasswordBox" Margin="0,0,0,10"/>
        <Button Content="Войти" Click="Login_Click"/>
        <Button Content="Отмена" IsCancel="True"/>
    </StackPanel>
</Window>
```

**LoginWindow.xaml.cs:**
```csharp
private void Login_Click(object sender, RoutedEventArgs e)
{
    string login = LoginBox.Text;
    string password = PasswordBox.Password;

    if (login == "admin" && password == "qwerty")
    {
        var adminWindow = new AdminWindow();
        adminWindow.ShowDialog();
        Close();
    }
    else if (login == "manager" && password == "12345")
    {
        var managerWindow = new ManagerWindow();
        managerWindow.ShowDialog();
        Close();
    }
    else
    {
        MessageBox.Show("Ошибка авторизации!");
    }
}
```

**MainWindow.xaml.cs (кнопка "Авторизоваться"):**
```csharp
private void AuthButton_Click(object sender, RoutedEventArgs e)
{
    Hide();
    var loginWindow = new LoginWindow();
    loginWindow.ShowDialog();
    Show();
}
```

---

#### **5.5 Диалоговое окно выбора цвета**

**ColorPickerWindow.xaml:**
```xml
<Window x:Class="Lab5_5.ColorPickerWindow"
        Title="Выбор цвета" Height="300" Width="400">
    <StackPanel Margin="10">
        <Rectangle x:Name="ColorPreview" Height="50" Stroke="Black"/>
        <Slider x:Name="RedSlider" Minimum="0" Maximum="255" ValueChanged="Slider_ValueChanged"/>
        <Slider x:Name="GreenSlider" Minimum="0" Maximum="255" ValueChanged="Slider_ValueChanged"/>
        <Slider x:Name="BlueSlider" Minimum="0" Maximum="255" ValueChanged="Slider_ValueChanged"/>
        <Button Content="OK" IsDefault="True" Click="OK_Click"/>
        <Button Content="Отмена" IsCancel="True"/>
    </StackPanel>
</Window>
```

**ColorPickerWindow.xaml.cs:**
```csharp
public Color SelectedColor { get; private set; }

private void Slider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
{
    SelectedColor = Color.FromRgb((byte)RedSlider.Value, (byte)GreenSlider.Value, (byte)BlueSlider.Value);
    ColorPreview.Fill = new SolidColorBrush(SelectedColor);
}

private void OK_Click(object sender, RoutedEventArgs e)
{
    DialogResult = true;
}
```

**Использование в главном окне:**
```csharp
private void ChangeColor_Click(object sender, RoutedEventArgs e)
{
    var colorPicker = new ColorPickerWindow();
    if (colorPicker.ShowDialog() == true)
    {
        Background = new SolidColorBrush(colorPicker.SelectedColor);
    }
}
```

---

### Ответы на контрольные вопросы

1. **Доступ к данным диалогового окна**: Через публичные свойства или методы окна.
2. **DialogResult**: `true`, `false` или `null`.
3. **Открыть диалоговое окно**: `ShowDialog()`.
4. **Недиалоговое окно**: `Show()`.
5. **Отличие режимов**: Диалоговое окно блокирует взаимодействие с родительским окном до закрытия.