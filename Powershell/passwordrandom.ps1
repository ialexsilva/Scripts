$Chars = [Char[]]"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
$PW=($Chars | GET-RANDOM -Count 16) -join ""
echo $PW