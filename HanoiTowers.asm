#Ana Carolina Arellano Valdez 	Alicia Sofia Gomez Galvez
#include <stdio.h>

#// Función recursiva para resolver las Torres de Hanoi
#void hanoi(int n, char origen, char auxiliar, char destino) {
#    if (n == 1) {
#        printf("Mover disco 1 de %c a %c\n", origen, destino);
#        return;
#    }

#    hanoi(n - 1, origen, destino, auxiliar);
#    printf("Mover disco %d de %c a %c\n", n, origen, destino);
#    hanoi(n - 1, auxiliar, origen, destino);
#}

#int main() {
#    int n;
#    printf("Ingrese el número de discos: ");
#    scanf("%d", &n);
#    hanoi(n, 'A', 'B', 'C');
#    return 0;
#}
