# Aplicación para la detección temprana de arritmias basado en los algoritmos de Pan & Tompkins, Elgendi y Boonperm

Las arritmias son anomalías en el correcto funcionamiento del sistema eléctrico del corazón. Las cuatro cámaras del corazón por lo general laten con un patrón estable y rítmico. La presencia de arritmias es peligrosa para quien las padece y de no ser tratadas a tiempo pueden devenir en enfermedades cardiovasculares que traerán consecuencias fatales y podrían producir la muerte. Para detectar arritmias cardiacas en forma temprana se suelen utilizar monitores de funciones vitales que son costosos, no son portables y cuyo software no es abierto. Ante este contexto se propone una aplicación para la detección de las arritmias: Bradicardia Sinusal, Taquicardia Ventricular, Fibrilación Auricular, Flutter Auricular y Aleteo Auricular, a partir de los algoritmos Pan y Tompkins, Elgendi y Boonperm cuyo código podría ser instalado en dispositivos móviles (Android y iOS) para que los monitores de funciones vitales no sean la única opción para poder detectar dichas arritmias. El algoritmo ensamblado ha sido probado con la base de datos de arritmias del MIT-BIH, primer conjunto de datos de prueba estándar disponible para el ámbito académico. Se analizaron los 48 registros de dicha base de datos y se obtuvo 37.22% de sensibilidad y 65.09% de predictividad en la detección de arritmias, a pesar de los valores obtenidos en la detección de los complejos QRS se obtuvo 99.02 sensibilidad y 99.11% predictividad, lo cual indica que el algoritmo híbrido es confiable solo para la detección de complejos QRS. 

Figura en la que se compara un electrocardiograma de un corazón sano y un electrocardiograma de una Fibrilación Auricular.

![ECG_RSN_FA](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/rsn_fa.png)

## Metodología

Para la presente investigación para la validación de la efectividad de la aplicación de detección de arritmias se implementará 3 algoritmos. Para la detección del complejo QRS se hace uso del algoritmo Pan Tompkins para detectar el complejo QRS y para las ondas P propuesta por Elgendi y para hallar las arritmias se utilizó las reglas de decisión de Parayikorn. La base de datos utilizada es la MIT-BIH Arrythmia Database del portal Physionet, la cual contiene 48 registros, cada registro digitalizado con 360 muestras/segundo y cada registro con 650000 muestras con registros de electrocardiogramas de diversas arritmias cada registro de 47 sujetos estudiados en el BIH Arrhythmia Laboratory entre 1975 y 1979. (Moody G.B & Mark R.G, 2001, p. 45-47)

Para descargarse los registros tiene que acceder a la siguiente url: https://archive.physionet.org/cgi-bin/atm/ATM tienes que seleccionar MIT-BIH Arrhythmia Database (mitdb) y en signals seleccionar MLII, en caso de los registros 102 y 104m seleccionar el registro V5 y descargarlos en formato .mat en toolbox seleccionar "Export signals as .mat" en la duración ponerle "to end" y en time format "time/date". Los registros descargdos ya estan en la carpeta registro de este repositorio en formato .mat.

**1. Pan & Tompkins, 1985** desarrollaron un algoritmo en tiempo real para la detección de complejos QRS en señales electrocardiográficas, el cual es capaz de detectar el complejo QRS basado en la pendiente, amplitud y ancho. Un filtro pasabanda especial reduce falsas detecciones causadas por varios tipos de ruido presentes en la señal ECG lo cual permite el uso de umbrales lo que aumenta la sensibilidad de detección. El algoritmo ajusta automáticamente los umbrales y los parámetros periódicamente para adaptarse a los cambios de electrocardiograma como la morfología QRS y la frecuencia cardíaca” (Pan Tompkins, 1985, p. 230).  Para el estándar de la base de datos de arritmias del MIT-BIH 24 horas, se replicó el algoritmo Pan-Tompkins en MATLAB detectando correctamente el 96,32% de los complejos QRS mientras que en el artículo original dice un 99.3% por lo tanto el valor obtenido oscila con el original.

![Picos R](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/PicoR.png)

## **Tabla de resultados Pan Tompkins**

| **Registro Mit** | **Numero de latidos** | **VP**     | **FP**  | **FN**   | **Sensibilidad** | **Predictividad** |
|--------------|-------------------|--------|-----|------|--------------|---------------|
| 100m         | 2273              | 2273   | 0   | 0    | 100.00       | 100.00        |
| 101m         | 1863              | 1862   | 6   | 1    | 99.95        | 99.68         |
| 102m         | 2187              | 2053   | 134 | 134  | 93.87        | 93.87         |
| 103m         | 2084              | 2083   | 0   | 1    | 99.95        | 100.00        |
| 104m         | 2229              | 2186   | 47  | 43   | 98.07        | 97.90         |
| 105m         | 2572              | 2558   | 53  | 14   | 99.46        | 97.97         |
| 106m         | 2027              | 2023   | 1   | 4    | 99.80        | 99.95         |
| 107m         | 2137              | 2111   | 6   | 26   | 98.78        | 99.72         |
| 108m         | 1763              | 1743   | 323 | 20   | 98.87        | 84.37         |
| 109m         | 2532              | 2526   | 1   | 6    | 99.76        | 99.96         |
| 111m         | 2124              | 2108   | 3   | 16   | 99.25        | 99.86         |
| 112m         | 2539              | 2539   | 0   | 0    | 100.00       | 100.00        |
| 113m         | 1795              | 1795   | 0   | 0    | 100.00       | 100.00        |
| 114m         | 1879              | 1877   | 1   | 2    | 99.89        | 99.95         |
| 115m         | 1953              | 1953   | 0   | 0    | 100.00       | 100.00        |
| 116m         | 2412              | 2388   | 4   | 24   | 99.00        | 99.83         |
| 117m         | 1535              | 1535   | 0   | 0    | 100.00       | 100.00        |
| 118m         | 2278              | 2278   | 1   | 0    | 100.00       | 99.96         |
| 119m         | 1987              | 1987   | 1   | 0    | 100.00       | 99.95         |
| 121m         | 1863              | 1861   | 0   | 2    | 99.89        | 100.00        |
| 122m         | 2476              | 2476   | 0   | 0    | 100.00       | 100.00        |
| 123m         | 1518              | 1515   | 0   | 3    | 99.80        | 100.00        |
| 124m         | 1619              | 1606   | 2   | 13   | 99.20        | 99.88         |
| 200m         | 2601              | 2595   | 7   | 6    | 99.77        | 99.73         |
| 201m         | 1963              | 1895   | 0   | 68   | 96.54        | 100.00        |
| 202m         | 2136              | 2126   | 0   | 10   | 99.53        | 100.00        |
| 203m         | 2976              | 2871   | 47  | 105  | 96.47        | 98.39         |
| 205m         | 2656              | 2651   | 2   | 5    | 99.81        | 99.92         |
| 207m         | 2332              | 1970   | 205 | 362  | 84.48        | 90.57         |
| 208m         | 2953              | 2907   | 6   | 46   | 98.44        | 99.79         |
| 209m         | 3005              | 3005   | 0   | 0    | 100.00       | 100.00        |
| 210m         | 2649              | 2591   | 23  | 58   | 97.81        | 99.12         |
| 212m         | 2748              | 2748   | 0   | 0    | 100.00       | 100.00        |
| 213m         | 3251              | 3218   | 31  | 33   | 98.98        | 99.05         |
| 214m         | 2262              | 2254   | 5   | 8    | 99.65        | 99.78         |
| 215m         | 3363              | 3359   | 0   | 4    | 99.88        | 100.00        |
| 217m         | 2208              | 2204   | 2   | 4    | 99.82        | 99.91         |
| 219m         | 2154              | 2154   | 0   | 0    | 100.00       | 100.00        |
| 220m         | 2048              | 2048   | 0   | 0    | 100.00       | 100.00        |
| 221m         | 2427              | 2423   | 0   | 4    | 99.84        | 100.00        |
| 222m         | 2483              | 2458   | 25  | 25   | 98.99        | 98.99         |
| 223m         | 2605              | 2593   | 0   | 12   | 99.54        | 100.00        |
| 228m         | 2053              | 2047   | 12  | 6    | 99.71        | 99.42         |
| 230m         | 2256              | 2256   | 0   | 0    | 100.00       | 100.00        |
| 231m         | 1571              | 1571   | 0   | 0    | 100.00       | 100.00        |
| 232m         | 1780              | 1780   | 2   | 0    | 100.00       | 99.89         |
| 233m         | 3079              | 3076   | 0   | 3    | 99.90        | 100.00        |
| 234m         | 2753              | 2750   | 0   | 3    | 99.89        | 100.00        |
| **48 registros** | 109957            | 108886 | 950 | 1071 | 99.03        | 99.14         |

**2. Elgendi, 2016** propuso un método basado en dos filtros de promedio móvil seguido de un umbral de duración de evento dinámico para detectar ondas P y T en señales electrocardiográficas. La detección de las ondas P y T es afectada por la calidad de las grabaciones de electrocardiogramas y las anormalidades de las señales electrocardiográficas. Dicho método detecta ondas P y T en señales electrocardiográficas de arritmias que sufren: 1) efectos no estacionarios, 2) baja relación señal / ruido, 3) Complejo auricular prematuro, 5) Bloques de rama izquierda y 6) Bloques de rama derecha. Cabe destacar que el detector de ondas P y T obtuvo una sensibilidad del 98.05 por ciento y una predictividad positiva del 97.11 por ciento para las ondas P sobre 10 registros de la base de datos de arritmia MIT-BIH con 21702 latidos

![Ondas P](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndaP.png)

## **Tabla de resultados Elgendi**

| **Registro Mit** | **Ondas P** | **VP**    | **FP**   | **FN**   | **Sensibilidad** | **Predictividad** |
|--------------|---------|-------|------|------|--------------|---------------|
| 100m         | 2257    | 2255  | 18   | 2    | 99.91        | 99.21         |
| 101m         | 1865    | 1849  | 12   | 16   | 99.14        | 99.36         |
| 103m         | 2084    | 2051  | 21   | 33   | 98.42        | 98.99         |
| 106m         | 1507    | 1467  | 541  | 40   | 97.35        | 73.06         |
| 117m         | 1534    | 1532  | 1    | 2    | 99.87        | 99.93         |
| 119m         | 1620    | 1616  | 449  | 4    | 99.75        | 78.26         |
| 122m         | 2475    | 2475  | 1    | 0    | 100.00       | 99.96         |
| 207m         | 1415    | 842   | 1099 | 573  | 59.51        | 43.38         |
| 214m         | 2001    | 1945  | 213  | 56   | 97.20        | 90.13         |
| 222m         | 1257    | 1136  | 1220 | 121  | 90.37        | 48.22         |
| 223m         | 2099    | 2062  | 526  | 37   | 98.24        | 79.68         |
| 231m         | 1994    | 1567  | 3    | 427  | 78.59        | 99.81         |
| **12 registros** | 22108   | 20797 | 4104 | 1311 | 94.07        | 83.52         |

**3. Boonperm, 2014** et al. propone un programa con interfaz gráfica que detecta arritmias usando MATLAB con los parámetros de el complejo QRS, la onda P, intervalo RR, el intervalo PR, y el ritmo del ECG usando la base de datos de arritmias del MIT.

***Cinco características para clasificar arritmias.***

| Arritmia                | Ritmo     | Ritmo cardiaco | Onda P | Intervalo PR | Complejo QRS |
|-------------------------|-----------|----------------|--------|--------------|--------------|
| Ritmo sinusal normal    | Regular   | 55-100 lpm     | 1      | 120-200 ms   | < 125 ms     |
| Bradicardia sinusal     | Regular   | < 55 lpm       | 1      | 120-200ms    | < 125 ms     |
| Fibrilación auricular   | Irregular | cualquiera     | >=1    | No           | < 125 ms     |
| Aleteo auricular        | Regular   | cualquiera     | >=1    | No           | < 125 ms     |
| Taquicardia ventricular | Regular   | >75 lpm        | No     | No           | > 125 ms     |
| Flutter ventricular     | Irregular | >120 lpm       | No     | No           | > 125 ms     |

![Arritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/Arritmias.png)

## **Tabla de resultados Arritmias**

| **Registro**     | **Arritmia**                | **Numero de latidos** | **VP**    | **FP**    | **FN**    | **Sensibilidad** | **Predictividad** |
|--------------|-------------------------|-------------------|-------|-------|-------|--------------|---------------|
| 100m         | Ritmo Sinusal Normal    | 2273              | 1571  | 0     | 702   | 69.12        | 100.00        |
| 101m         | Ritmo Sinusal Normal    | 1863              | 1790  | 0     | 73    | 96.08        | 100.00        |
| 102m         | Ritmo Sinusal Normal    | 102               | 66    | 75    | 36    | 64.71        | 46.81         |
| 102m         | Otra Arritmia           | 2085              | 1140  | 49    | 945   | 54.68        | 95.88         |
| 103m         | Ritmo Sinusal Normal    | 2084              | 1532  | 0     | 552   | 73.51        | 100.00        |
| 104m         | Ritmo Sinusal Normal    | 289               | 52    | 92    | 237   | 17.99        | 36.11         |
| 104m         | Otra Arritmia           | 1940              | 655   | 145   | 1285  | 33.76        | 81.88         |
| 105m         | Ritmo Sinusal Normal    | 2572              | 305   | 1     | 2267  | 11.86        | 99.67         |
| 106m         | Ritmo Sinusal Normal    | 1483              | 741   | 1     | 742   | 49.97        | 99.87         |
| 106m         | Taquicardia ventricular | 3                 | 0     | 5     | 3     | 0.00         | 0.00          |
| 106m         | Otra Arritmia           | 541               | 297   | 318   | 244   | 54.90        | 48.29         |
| 107m         | Otra Arritmia           | 2137              | 2041  | 4     | 96    | 95.51        | 99.80         |
| 108m         | Ritmo Sinusal Normal    | 1763              | 291   | 1     | 1472  | 16.51        | 99.66         |
| 109m         | Ritmo Sinusal Normal    | 2532              | 88    | 0     | 2444  | 3.48         | 100.00        |
| 111m         | Ritmo Sinusal Normal    | 2124              | 25    | 1     | 2099  | 1.18         | 96.15         |
| 112m         | Ritmo Sinusal Normal    | 2539              | 654   | 0     | 1885  | 25.76        | 100.00        |
| 113m         | Ritmo Sinusal Normal    | 1795              | 1321  | 0     | 474   | 73.59        | 100.00        |
| 114m         | Ritmo Sinusal Normal    | 1872              | 297   | 0     | 1575  | 15.87        | 100.00        |
| 114m         | Otra Arritmia           | 7                 | 4     | 1427  | 3     | 57.14        | 0.28          |
| 115m         | Ritmo Sinusal Normal    | 1953              | 1658  | 0     | 295   | 84.90        | 100.00        |
| 116m         | Ritmo Sinusal Normal    | 2412              | 1370  | 0     | 1042  | 56.80        | 100.00        |
| 117m         | Ritmo Sinusal Normal    | 1535              | 12    | 0     | 1523  | 0.78         | 100.00        |
| 118m         | Ritmo Sinusal Normal    | 2278              | 799   | 0     | 1479  | 35.07        | 100.00        |
| 119m         | Ritmo Sinusal Normal    | 1498              | 955   | 73    | 543   | 63.75        | 92.90         |
| 119m         | Otra Arritmia           | 489               | 208   | 203   | 281   | 42.54        | 50.61         |
| 121m         | Ritmo Sinusal Normal    | 1863              | 407   | 0     | 1456  | 21.85        | 100.00        |
| 122m         | Ritmo Sinusal Normal    | 2476              | 2458  | 0     | 18    | 99.27        | 100.00        |
| 123m         | Ritmo Sinusal Normal    | 1518              | 95    | 0     | 1423  | 6.26         | 100.00        |
| 124m         | Ritmo Sinusal Normal    | 1534              | 183   | 11    | 1351  | 11.93        | 94.33         |
| 124m         | Otra Arritmia           | 85                | 52    | 543   | 33    | 61.18        | 8.74          |
| 200m         | Ritmo Sinusal Normal    | 1398              | 384   | 24    | 1014  | 27.47        | 94.12         |
| 200m         | Taquicardia ventricular | 23                | 5     | 367   | 18    | 21.74        | 1.34          |
| 200m         | Otra Arritmia           | 1180              | 352   | 114   | 828   | 29.83        | 75.54         |
| 201m         | Ritmo Sinusal Normal    | 691               | 28    | 151   | 663   | 4.05         | 15.64         |
| 201m         | Fibrilacion Auricular   | 911               | 130   | 203   | 781   | 14.27        | 39.04         |
| 201m         | Otra Arritmia           | 361               | 184   | 467   | 177   | 50.97        | 28.26         |
| 202m         | Ritmo Sinusal Normal    | 1092              | 129   | 67    | 963   | 11.81        | 65.82         |
| 202m         | Aleteo Auricular        | 104               | 79    | 154   | 25    | 75.96        | 33.91         |
| 202m         | Fibrilacion Auricular   | 940               | 86    | 39    | 854   | 9.15         | 68.80         |
| 203m         | Aleteo Auricular        | 536               | 68    | 155   | 468   | 12.69        | 30.49         |
| 203m         | Fibrilacion Auricular   | 2354              | 378   | 185   | 1976  | 16.06        | 67.14         |
| 203m         | Taquicardia ventricular | 79                | 16    | 692   | 63    | 20.25        | 2.26          |
| 203m         | Otra Arritmia           | 7                 | 1     | 783   | 6     | 14.29        | 0.13          |
| 205m         | Ritmo Sinusal Normal    | 2607              | 2502  | 0     | 105   | 95.97        | 100.00        |
| 205m         | Taquicardia ventricular | 49                | 19    | 29    | 30    | 38.78        | 39.58         |
| 207m         | Ritmo Sinusal Normal    | 1485              | 5     | 2     | 1480  | 0.34         | 71.43         |
| 207m         | Taquicardia ventricular | 6                 | 0     | 492   | 6     | 0.00         | 0.00          |
| 207m         | Flutter ventricular     | 472               | 69    | 49    | 403   | 14.62        | 58.47         |
| 207m         | Otra Arritmia           | 369               | 152   | 1268  | 217   | 41.19        | 10.70         |
| 208m         | Ritmo Sinusal Normal    | 2443              | 255   | 137   | 2188  | 10.44        | 65.05         |
| 208m         | Otra Arritmia           | 510               | 58    | 487   | 452   | 11.37        | 10.64         |
| 209m         | Ritmo Sinusal Normal    | 2744              | 1377  | 0     | 1367  | 50.18        | 100.00        |
| 209m         | Otra Arritmia           | 261               | 5     | 3     | 256   | 1.92         | 62.50         |
| 210m         | Fibrilacion Auricular   | 2591              | 193   | 16    | 2398  | 7.45         | 92.34         |
| 210m         | Taquicardia ventricular | 12                | 1     | 1255  | 11    | 8.33         | 0.08          |
| 210m         | Otra Arritmia           | 46                | 10    | 413   | 36    | 21.74        | 2.36          |
| 212m         | Ritmo Sinusal Normal    | 2748              | 2398  | 0     | 350   | 87.26        | 100.00        |
| 213m         | Ritmo Sinusal Normal    | 3135              | 13    | 0     | 3122  | 0.41         | 100.00        |
| 213m         | Taquicardia ventricular | 7                 | 2     | 358   | 5     | 28.57        | 0.56          |
| 213m         | Otra Arritmia           | 109               | 0     | 8     | 109   | 0.00         | 0.00          |
| 214m         | Ritmo Sinusal Normal    | 2168              | 402   | 7     | 1766  | 18.54        | 98.29         |
| 214m         | Taquicardia ventricular | 6                 | 1     | 655   | 5     | 16.67        | 0.15          |
| 214m         | Otra Arritmia           | 88                | 20    | 881   | 68    | 22.73        | 2.22          |
| 215m         | Ritmo Sinusal Normal    | 3357              | 16    | 0     | 3341  | 0.48         | 100.00        |
| 215m         | Taquicardia ventricular | 6                 | 0     | 995   | 6     | 0.00         | 0.00          |
| 217m         | Fibrilacion Auricular   | 338               | 10    | 12    | 328   | 2.96         | 45.45         |
| 217m         | Taquicardia ventricular | 3                 | 0     | 314   | 3     | 0.00         | 0.00          |
| 217m         | Otra Arritmia           | 1867              | 1571  | 131   | 296   | 84.15        | 92.30         |
| 219m         | Ritmo Sinusal Normal    | 329               | 20    | 549   | 309   | 6.08         | 3.51          |
| 219m         | Fibrilacion Auricular   | 1802              | 319   | 188   | 1483  | 17.70        | 62.92         |
| 219m         | Otra Arritmia           | 23                | 8     | 506   | 15    | 34.78        | 1.56          |
| 220m         | Ritmo Sinusal Normal    | 2021              | 673   | 1     | 1348  | 33.30        | 99.85         |
| 220m         | Otra Arritmia           | 27                | 1     | 850   | 26    | 3.70         | 0.12          |
| 221m         | Fibrilacion Auricular   | 2357              | 294   | 11    | 2063  | 12.47        | 96.39         |
| 221m         | Taquicardia ventricular | 6                 | 2     | 631   | 4     | 33.33        | 0.32          |
| 221m         | Otra Arritmia           | 64                | 30    | 804   | 34    | 46.88        | 3.60          |
| 222m         | Ritmo Sinusal Normal    | 1181              | 814   | 74    | 367   | 68.92        | 91.67         |
| 222m         | Aleteo Auricular        | 742               | 181   | 123   | 561   | 24.39        | 59.54         |
| 222m         | Fibrilacion Auricular   | 188               | 42    | 514   | 146   | 22.34        | 7.55          |
| 222m         | Otra Arritmia           | 372               | 157   | 212   | 215   | 42.20        | 42.55         |
| 223m         | Ritmo Sinusal Normal    | 1996              | 863   | 28    | 1133  | 43.24        | 96.86         |
| 223m         | Taquicardia ventricular | 181               | 86    | 805   | 95    | 47.51        | 9.65          |
| 223m         | Otra Arritmia           | 428               | 65    | 134   | 363   | 15.19        | 32.66         |
| 228m         | Ritmo Sinusal Normal    | 1659              | 173   | 2     | 1486  | 10.43        | 98.86         |
| 228m         | Otra Arritmia           | 394               | 232   | 315   | 162   | 58.88        | 42.41         |
| 230m         | Ritmo Sinusal Normal    | 1341              | 820   | 55    | 521   | 61.15        | 93.71         |
| 230m         | Otra Arritmia           | 915               | 449   | 262   | 466   | 49.07        | 63.15         |
| 231m         | Ritmo Sinusal Normal    | 1151              | 1045  | 0     | 106   | 90.79        | 100.00        |
| 231m         | Otra Arritmia           | 420               | 4     | 17    | 416   | 0.95         | 19.05         |
| 232m         | Bradicardia Sinusal     | 1780              | 20    | 0     | 1760  | 1.12         | 100.00        |
| 233m         | Ritmo Sinusal Normal    | 2871              | 169   | 0     | 2702  | 5.89         | 100.00        |
| 233m         | Taquicardia ventricular | 18                | 5     | 797   | 13    | 27.78        | 0.62          |
| 233m         | Otra Arritmia           | 190               | 100   | 614   | 90    | 52.63        | 14.01         |
| 234m         | Ritmo Sinusal Normal    | 2703              | 2587  | 3     | 116   | 95.71        | 99.88         |
| 234m         | Otra Arritmia           | 50                | 2     | 0     | 48    | 4.00         | 100.00        |
| **48 registros** |                         | 109957            | 41147 | 21357 | 68810 | 37.42 | 65.83   |


## Conclusiones

* Se implementó el algoritmo Pan Tompkins para hallar los picos R con una sensibilidad de 99.03% y predictividad de 99.14% sobre los 48 registros que proporciona la base de datos de arritmias del MIT-BIH 24H.
* Se implementó el algoritmo de Mohamed Elgendi para hallar las ondas P con una sensibilidad de 94.07% y predictividad de 83.52% sobre los 12 registros que proporciona la base de datos de arritmias del MIT-BIH 24H para las ondas P.
* Se implementó las reglas de decisión de Parayikorn para poder detectar las arritmias con una sensibilidad de 37.42% y predictividad de 65.83% sobre los 48 registros de la base de datos de arritmias del MIT-BIH 24H.