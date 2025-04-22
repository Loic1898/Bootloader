[bits 16]
[org 0x7C00]

main:
    xor ax, ax ;initialise ax à 0
    mov ds, ax ;initialise ds à 0
    mov es, ax ;initialise es à 0
    mov ss, ax ;initialise ss à 0
    mov sp, 0X7C00 ;la pile est initialisée avant le code

    mov si, message ;message à afficher
    cld ;DF==0
    call print_string ;écrit le message

    jmp $ ;saute vers l'adresse actuelle (boucle infinie pour ne pas que le processeur essaye d'exécuter les données juste en dessous du code)

print_string:
    mov ah, 0x0E ;BIOS teletype
.loop:
    lodsb ;mov al, [si] et inc si car DF==0

    cmp al, 0
    je done ;si al==0 on va dans done

    int 0x10 ;affiche al à l'écran

    jmp .loop ;boucle

done:
    ret ;retourne à main

;données

message:
    db " ____   ___   ___ _____ _     ___    _    ____  _____ ____ ", 13, 10
    db "| __ ) / _ \ / _ \_   _| |   / _ \  / \  |  _ \| ____|  _ \", 13, 10
    db "|  _ \| | | | | | || | | |  | | | |/ _ \ | | | |  _| | |_) |", 13, 10
    db "| |_) | |_| | |_| || | | |__| |_| / ___ \| |_| | |___|  _ < ", 13, 10
    db "|____/ \___/ \___/ |_| |_____\___/_/   \_\____/|_____|_| \_\", 13, 10, 0

times 510-($-$$) db 0 ;remplir jusqu'à 510 octets / 510 - ($ - $$) = 510 - (adresse actuelle - adresse de début) = nombre d'octets restants à remplir avant les 2 derniers octets
dw 0xAA55 ;signature du secteur de boot