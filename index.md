## Bienvenido a mi página de Aplicación para detectar arritmias basado en los algoritmos de Pan & Tompkins, Elgendi y Boonperm

Las arritmias son anomalías en el correcto funcionamiento del sistema eléctrico del corazón. Las cuatro cámaras del corazón por lo general laten con un patrón estable y rítmico. La presencia de arritmias es peligrosa para quien las padece y de no ser tratadas a tiempo pueden devenir en enfermedades cardiovasculares que traerán consecuencias fatales y podrían producir la muerte. Para detectar arritmias cardiacas en forma temprana se suelen utilizar monitores de funciones vitales que son costosos, no son portables y cuyo software no es abierto. Ante este contexto se propone una aplicación para la detección de las arritmias: Bradicardia Sinusal, Taquicardia Ventricular, Fibrilación Auricular, Flutter Auricular y Aleteo Auricular, a partir de los algoritmos Pan y Tompkins, Elgendi y Boonperm cuyo código podría ser instalado en dispositivos móviles (Android y iOS) para que los monitores de funciones vitales no sean la única opción para poder detectar dichas arritmias. El algoritmo ensamblado ha sido probado con la base de datos de arritmias del MIT-BIH, primer conjunto de datos de prueba estándar disponible para el ámbito académico. Se analizaron los 48 registros de dicha base de datos y se obtuvo 30.76% de sensibilidad y 53.60% de predictividad en la detección de arritmias, a pesar de los valores obtenidos en la detección de los complejos QRS se obtuvo 96.43 sensibilidad y 96.37% predictividad, lo cual indica que el algoritmo híbrido es confiable solo para la detección de complejos QRS. 

Figura en la que se compara un electrocardiograma de un corazón sano y un electrocardiograma de una Fibrilación Auricular.

![ECG_RSN_FA](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/rsn_fa.png)

## Requisitos

- MATLAB 2015 o superior
- PC con procesador con Intel Core i3 o superior
- MySQL 5.0 o superior

## Pasos para poder ejecutar el programa

En la consola de mysql ejecutar

```
mysql> \. rutaProyecto\MitArrythmiaDatabase.sql
```

Después será capaz de ejecutar el programa de detección de arritmias, el de los picos R y el de los puntos P.

## Metodología

Para la presente investigación para la validación de la efectividad de la aplicación de detección de arritmias se implementará 3 algoritmos. Para la detección del complejo QRS se hace uso del algoritmo Pan Tompkins para detectar el complejo QRS y para las ondas P propuesta por Elgendi y para hallar las arritmias se utilizó las reglas de decisión de Parayikorn. La base de datos utilizada es la MIT-BIH Arrythmia Database del portal Physionet, la cual contiene 48 registros, cada registro digitalizado con 360 muestras/segundo y cada registro con 650000 muestras con registros de electrocardiogramas de diversas arritmias cada registro de 47 sujetos estudiados en el BIH Arrhythmia Laboratory entre 1975 y 1979. (Moody G.B & Mark R.G, 2001, p. 45-47)

Para descargarse los registros tiene que acceder a la siguiente url: https://archive.physionet.org/cgi-bin/atm/ATM tienes que seleccionar MIT-BIH Arrhythmia Database (mitdb) y en signals seleccionar MLII, en caso de los registros 102 y 104m seleccionar el registro V5 y descargarlos en formato .mat en toolbox seleccionar "Export signals as .mat" en la duración ponerle "to end" y en time format "time/date". Los registros descargdos ya estan en la carpeta registro de este repositorio en formato .mat.

**1. Pan & Tompkins, 1985** desarrollaron un algoritmo en tiempo real para la detección de complejos QRS en señales electrocardiográficas, el cual es capaz de detectar el complejo QRS basado en la pendiente, amplitud y ancho. Un filtro pasabanda especial reduce falsas detecciones causadas por varios tipos de ruido presentes en la señal ECG lo cual permite el uso de umbrales lo que aumenta la sensibilidad de detección. El algoritmo ajusta automáticamente los umbrales y los parámetros periódicamente para adaptarse a los cambios de electrocardiograma como la morfología QRS y la frecuencia cardíaca” (Pan Tompkins, 1985, p. 230).  Para el estándar de la base de datos de arritmias del MIT-BIH 24 horas, se replicó el algoritmo Pan-Tompkins en MATLAB detectando correctamente el 96,32% de los complejos QRS mientras que en el artículo original dice un 99.3% por lo tanto el valor obtenido oscila con el original.

Para poder ejecutar el programa ubicarse sobre el archivo **PicoR.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide PicosR](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/picoROpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - Picos R](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/picoRPlay.png)

Después se abrirá el programa para hallar los Picos R. Selecciona el registro a analizar(100m-234m). Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. 

![Picos R](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/PicoR.png)

**Tabla de resultados Pan Tompkins**

| registromit | Numero de latidos | VPR  | FPR | FNR | Sensibilidad | Predictividad |
|-------------|-------------------|------|-----|-----|--------------|---------------|
| 100m        | 2273              | 2273 | 0   | 0   | 100          | 100           |
| 101m        | 1863              | 1862 | 6   | 1   | 99.94632313  | 99.67880086   |
| 102m        | 2187              | 2085 | 102 | 102 | 95.33607682  | 95.33607682   |
| 103m        | 2084              | 2083 | 0   | 1   | 99.95201536  | 100           |
| 104m        | 2229              | 1526 | 706 | 703 | 68.46119336  | 68.36917563   |
| 105m        | 2572              | 2524 | 90  | 48  | 98.13374806  | 96.55700077   |
| 106m        | 2027              | 1996 | 30  | 31  | 98.47064628  | 98.51924975   |
| 107m        | 2137              | 1360 | 761 | 777 | 63.64061769  | 64.12069778   |
| 108m        | 1761              | 1654 | 487 | 107 | 93.92390687  | 77.2536198    |
| 109m        | 2532              | 2518 | 9   | 14  | 99.44707741  | 99.64384646   |
| 111m        | 2123              | 2105 | 10  | 18  | 99.15214319  | 99.52718676   |
| 112m        | 2539              | 2539 | 0   | 0   | 100          | 100           |
| 113m        | 1789              | 1789 | 6   | 0   | 100          | 99.66573816   |
| 114m        | 1879              | 1876 | 1   | 3   | 99.84034061  | 99.94672349   |
| 115m        | 1953              | 1953 | 0   | 0   | 100          | 100           |
| 116m        | 2412              | 2388 | 5   | 24  | 99.00497512  | 99.79105725   |
| 117m        | 1535              | 1535 | 0   | 0   | 100          | 100           |
| 118m        | 2274              | 2255 | 24  | 19  | 99.1644679   | 98.94690654   |
| 119m        | 1987              | 1987 | 1   | 0   | 100          | 99.94969819   |
| 121m        | 1863              | 1861 | 0   | 2   | 99.89264627  | 100           |
| 122m        | 2476              | 2476 | 0   | 0   | 100          | 100           |
| 123m        | 1518              | 1515 | 0   | 3   | 99.80237154  | 100           |
| 124m        | 1619              | 1601 | 11  | 18  | 98.88820259  | 99.31761787   |
| 200m        | 2601              | 2581 | 18  | 20  | 99.23106498  | 99.30742593   |
| 201m        | 1961              | 1827 | 90  | 134 | 93.16675166  | 95.30516432   |
| 202m        | 2136              | 2116 | 13  | 20  | 99.06367041  | 99.38938469   |
| 203m        | 2974              | 2784 | 134 | 190 | 93.61129792  | 95.40781357   |
| 205m        | 2656              | 2644 | 6   | 12  | 99.54819277  | 99.77358491   |
| 207m        | 2332              | 1887 | 337 | 445 | 80.91766724  | 84.8471223    |
| 208m        | 2953              | 2918 | 14  | 35  | 98.81476465  | 99.52251023   |
| 209m        | 3005              | 3004 | 2   | 1   | 99.96672213  | 99.9334664    |
| 210m        | 2649              | 2570 | 38  | 79  | 97.01774254  | 98.54294479   |
| 212m        | 2748              | 2748 | 1   | 0   | 100          | 99.96362314   |
| 213m        | 3251              | 3222 | 26  | 29  | 99.10796678  | 99.19950739   |
| 214m        | 2262              | 2147 | 112 | 115 | 94.91600354  | 95.04205401   |
| 215m        | 3363              | 3360 | 0   | 3   | 99.91079393  | 100           |
| 217m        | 2208              | 1327 | 874 | 881 | 60.09963768  | 60.29077692   |
| 219m        | 2154              | 2152 | 1   | 2   | 99.90714949  | 99.95355318   |
| 220m        | 2048              | 2048 | 0   | 0   | 100          | 100           |
| 221m        | 2427              | 2423 | 1   | 4   | 99.83518747  | 99.95874587   |
| 222m        | 2483              | 2463 | 35  | 20  | 99.19452275  | 98.5988791    |
| 223m        | 2605              | 2595 | 0   | 10  | 99.61612284  | 100           |
| 228m        | 2053              | 2016 | 35  | 37  | 98.19775938  | 98.29351536   |
| 230m        | 2256              | 2256 | 0   | 0   | 100          | 100           |
| 231m        | 1571              | 1571 | 0   | 0   | 100          | 100           |
| 232m        | 1780              | 1774 | 9   | 6   | 99.66292135  | 99.49523275   |
| 233m        | 3079              | 3076 | 1   | 3   | 99.90256577  | 99.96750081   |
| 234m        | 2753              | 2752 | 0   | 1   | 99.96367599  | 100           |
| 48 registros | 109940 | 106022 | 3996 | 3918 | 96.43623795 | 96.36786708 |

**2. Elgendi, 2014** propuso un método basado en dos filtros de promedio móvil seguido de un umbral de duración de evento dinámico para detectar ondas P y T en señales electrocardiográficas. La detección de las ondas P y T es afectada por la calidad de las grabaciones de electrocardiogramas y las anormalidades de las señales electrocardiográficas. Dicho método detecta ondas P y T en señales electrocardiográficas de arritmias que sufren: 1) efectos no estacionarios, 2) baja relación señal / ruido, 3) Complejo auricular prematuro, 5) Bloques de rama izquierda y 6) Bloques de rama derecha. Cabe destacar que el detector de ondas P y T obtuvo una sensibilidad del 98.05 por ciento y una predictividad positiva del 97.11 por ciento para las ondas P sobre 10 registros de la base de datos de arritmia MIT-BIH con 21702 latidos

Para poder ejecutar el programa ubicarse sobre el archivo **OndasPT.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide OndasP](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndasPOpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - Ondas P](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndaPPlay.png)

Después se abrirá el programa para hallar los Ondas P. Selecciona un registros de los 12 registros de la Onda P del MIT-BIH Arrythmias Database. Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. 

![Ondas P](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndaP.png)

**Tabla de resultados Elgendi**

| Registro MIT | Número de ondas P | Verdaderos positivos | Falsos negativos | Falsos positivos | Sensibilidad | Predictividad |
|--------------|-------------------|----------------------|------------------|------------------|--------------|---------------|
| 100m         | 2257              | 2255.00              | 2.00             | 18.00            | 99.9113868   | 99.20809503   |
| 101m         | 1865              | 1859                 | 6                | 7                | 99.67828418  | 99.62486602   |
| 103m         | 2084              | 2069                 | 15               | 9                | 99.28023033  | 99.56689124   |
| 106m         | 1507              | 1500                 | 7                | 526              | 99.535501    | 74.03751234   |
| 117m         | 1534              | 1533                 | 1                | 2                | 99.93481095  | 99.86970684   |
| 119m         | 1620              | 1617                 | 3                | 448              | 99.81481481  | 78.30508475   |
| 122m         | 2475              | 2475                 | 0                | 1                | 100          | 99.95961228   |
| 207m         | 1415              | 197                  | 1218             | 1484             | 13.92226148  | 11.71921475   |
| 214m         | 2001              | 1954                 | 47               | 299              | 97.65117441  | 86.72880604   |
| 222m         | 1257              | 1177                 | 80               | 1230             | 93.63564041  | 48.89904445   |
| 223m         | 2099              | 2079                 | 20               | 497              | 99.04716532  | 80.70652174   |
| 231m         | 1994              | 1567                 | 427              | 3                | 78.58575727  | 99.8089172    |
| 12 registros | 22108 | 20282 | 1826 | 4524 | 91.74054641 | 81.76247682 |

**3. Boonperm, 2014** et al. propone un programa con interfaz gráfica que detecta arritmias usando MATLAB con los parámetros de el complejo QRS, la onda P, intervalo RR, el intervalo PR, y el ritmo del ECG usando la base de datos de arritmias del MIT.

***Cinco características para clasificar arritmias.***

| Arritmia                | Ritmo     | Ritmo cardiaco | Onda P | Intervalo PR | Complejo QRS |
|-------------------------|-----------|----------------|--------|--------------|--------------|
| Ritmo sinusal normal    | Regular   | 55-100 lpm     | 1      | 120-200 ms   | < 125 ms     |
| Bradicardia sinusal     | Regular   | < 55 lpm       | 1      | 120-200ms    | < 125 ms     |
| Fibrilación auricular   | Irregular | cualquiera     | >=1    | No           | < 125 ms     |
| Flutter atrial          | Regular   | cualquiera     | >=1    | No           | < 125 ms     |
| Taquicardia ventricular | Regular   | >75 lpm        | No     | No           | < 125 ms     |
| Fibrilación ventricular | Irregular | >120 lpm       | No     | No           | < 125 ms     |

Para poder ejecutar el programa ubicarse sobre el archivo **DetectorArritmias.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide DetectorArritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/ArritmiasOpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - DetectorArritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/ArritmiasPlay.png)

Después se abrirá el programa para detectar las arritmias. Selecciona un registros de los 48 del MIT-BIH 24h Arrythmias Database. Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. La aplicación detecta la arritmia y te dice en que muestra la detecta.

![Arritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/Arritmias.png)

**Tabla de resultados Arritmias**

| Registro     | Arritmia                | Sensibilidad | Predictividad | Numero de latidos | VP    | FP    | FN    |
|--------------|-------------------------|--------------|---------------|-------------------|-------|-------|-------|
| 100m         | Ritmo Sinusal Normal    | 95.64        | 100.00        | 2273              | 2174  | 0     | 99    |
| 101m         | Ritmo Sinusal Normal    | 44.63        | 100.00        | 1873              | 836   | 0     | 1037  |
| 102m         | Ritmo Sinusal Normal    | 0.98         | 1.79          | 102               | 1     | 55    | 101   |
| 102m         | Otra Arritmia           | 69.88        | 94.37         | 2085              | 1457  | 87    | 628   |
| 103m         | Ritmo Sinusal Normal    | 92.06        | 100.00        | 2090              | 1924  | 0     | 166   |
| 104m         | Ritmo Sinusal Normal    | 5.30         | 66.67         | 302               | 16    | 8     | 286   |
| 104m         | Otra Arritmia           | 48.73        | 70.63         | 1964              | 957   | 398   | 1007  |
| 105m         | Ritmo Sinusal Normal    | 3.35         | 100.00        | 2690              | 90    | 0     | 2600  |
| 106m         | Ritmo Sinusal Normal    | 18.36        | 100.00        | 1509              | 277   | 0     | 1232  |
| 106m         | Taquicardia ventricular | 0.00         | 0.00          | 3                 | 0     | 22    | 3     |
| 106m         | Otra Arritmia           | 58.27        | 34.49         | 544               | 317   | 602   | 227   |
| 107m         | Otra Arritmia           | 63.02        | 79.72         | 2139              | 1348  | 343   | 791   |
| 108m         | Ritmo Sinusal Normal    | 2.91         | 98.15         | 1823              | 53    | 1     | 1770  |
| 109m         | Ritmo Sinusal Normal    | 33.50        | 100.00        | 2534              | 849   | 0     | 1685  |
| 111m         | Ritmo Sinusal Normal    | 1.69         | 100.00        | 2132              | 36    | 0     | 2096  |
| 112m         | Ritmo Sinusal Normal    | 73.13        | 100.00        | 2549              | 1864  | 0     | 685   |
| 113m         | Ritmo Sinusal Normal    | 78.77        | 100.00        | 1795              | 1414  | 0     | 381   |
| 114m         | Ritmo Sinusal Normal    | 0.25         | 100.00        | 1215              | 3     | 0     | 1212  |
| 114m         | Otra Arritmia           | 71.43        | 0.27          | 7                 | 5     | 1814  | 2     |
| 115m         | Ritmo Sinusal Normal    | 90.92        | 100.00        | 1961              | 1783  | 0     | 178   |
| 116m         | Ritmo Sinusal Normal    | 21.49        | 100.00        | 2420              | 520   | 0     | 1900  |
| 117m         | Ritmo Sinusal Normal    | 1.63         | 100.00        | 1538              | 25    | 0     | 1513  |
| 118m         | Ritmo Sinusal Normal    | 22.61        | 100.00        | 2300              | 520   | 0     | 1780  |
| 119m         | Ritmo Sinusal Normal    | 60.60        | 92.85         | 1500              | 909   | 70    | 591   |
| 119m         | Otra Arritmia           | 54.99        | 49.36         | 491               | 270   | 277   | 221   |
| 121m         | Ritmo Sinusal Normal    | 16.21        | 100.00        | 1875              | 304   | 0     | 1571  |
| 122m         | Ritmo Sinusal Normal    | 70.02        | 100.00        | 2478              | 1735  | 0     | 743   |
| 123m         | Ritmo Sinusal Normal    | 6.13         | 100.00        | 1518              | 93    | 0     | 1425  |
| 124m         | Ritmo Sinusal Normal    | 0.33         | 83.33         | 1536              | 5     | 1     | 1531  |
| 124m         | Otra Arritmia           | 77.65        | 4.35          | 85                | 66    | 1450  | 19    |
| 200m         | Ritmo Sinusal Normal    | 19.96        | 98.61         | 1423              | 284   | 4     | 1139  |
| 200m         | Taquicardia ventricular | 17.39        | 0.49          | 23                | 4     | 811   | 19    |
| 200m         | Otra Arritmia           | 61.94        | 77.45         | 1198              | 742   | 216   | 456   |
| 201m         | Ritmo Sinusal Normal    | 2.05         | 31.25         | 730               | 15    | 33    | 715   |
| 201m         | Fibrilacion Auricular   | 4.28         | 31.97         | 911               | 39    | 83    | 872   |
| 201m         | Otra Arritmia           | 58.40        | 21.03         | 363               | 212   | 796   | 151   |
| 202m         | Ritmo Sinusal Normal    | 0.27         | 75.00         | 1094              | 3     | 1     | 1091  |
| 202m         | Aleteo Auricular        | 0.00         | 0.00          | 104               | 0     | 2     | 104   |
| 202m         | Fibrilacion Auricular   | 0.11         | 20.00         | 940               | 1     | 4     | 939   |
| 203m         | Aleteo Auricular        | 6.70         | 38.78         | 567               | 38    | 60    | 529   |
| 203m         | Fibrilacion Auricular   | 5.44         | 60.93         | 2409              | 131   | 84    | 2278  |
| 203m         | Taquicardia ventricular | 11.25        | 1.00          | 80                | 9     | 890   | 71    |
| 203m         | Otra Arritmia           | 28.57        | 0.20          | 7                 | 2     | 983   | 5     |
| 205m         | Ritmo Sinusal Normal    | 80.88        | 100.00        | 2610              | 2111  | 0     | 499   |
| 205m         | Taquicardia ventricular | 20.41        | 5.03          | 49                | 10    | 189   | 39    |
| 207m         | Ritmo Sinusal Normal    | 0.13         | 11.11         | 1505              | 2     | 16    | 1503  |
| 207m         | Taquicardia ventricular | 33.33        | 0.40          | 6                 | 2     | 493   | 4     |
| 207m         | Flutter ventricular     | 12.13        | 35.58         | 478               | 58    | 105   | 420   |
| 207m         | Otra Arritmia           | 39.52        | 10.34         | 372               | 147   | 1274  | 225   |
| 208m         | Ritmo Sinusal Normal    | 6.27         | 66.52         | 2473              | 155   | 78    | 2318  |
| 208m         | Otra Arritmia           | 11.87        | 10.15         | 514               | 61    | 540   | 453   |
| 209m         | Ritmo Sinusal Normal    | 63.57        | 100.00        | 2770              | 1761  | 0     | 1009  |
| 209m         | Otra Arritmia           | 2.68         | 58.33         | 261               | 7     | 5     | 254   |
| 210m         | Fibrilacion Auricular   | 0.73         | 70.37         | 2610              | 19    | 8     | 2591  |
| 210m         | Taquicardia ventricular | 0.00         | 0.00          | 12                | 0     | 1821  | 12    |
| 210m         | Otra Arritmia           | 34.78        | 2.67          | 46                | 16    | 583   | 30    |
| 212m         | Ritmo Sinusal Normal    | 55.61        | 100.00        | 2762              | 1536  | 0     | 1226  |
| 213m         | Ritmo Sinusal Normal    | 0.22         | 100.00        | 3135              | 7     | 0     | 3128  |
| 213m         | Taquicardia ventricular | 57.14        | 0.55          | 7                 | 4     | 724   | 3     |
| 213m         | Otra Arritmia           | 0.00         | 0.00          | 109               | 0     | 14    | 109   |
| 214m         | Ritmo Sinusal Normal    | 0.05         | 100.00        | 2142              | 1     | 0     | 2141  |
| 214m         | Taquicardia ventricular | 16.67        | 0.11          | 6                 | 1     | 931   | 5     |
| 214m         | Otra Arritmia           | 29.27        | 3.32          | 123               | 36    | 1049  | 87    |
| 215m         | Ritmo Sinusal Normal    | 0.28         | 50.00         | 2520              | 7     | 7     | 2513  |
| 215m         | Taquicardia ventricular | 16.67        | 0.06          | 6                 | 1     | 1620  | 5     |
| 215m         | Otra Arritmia           | 4.27         | 31.90         | 867               | 37    | 79    | 830   |
| 217m         | Fibrilacion Auricular   | 7.65         | 60.47         | 340               | 26    | 17    | 314   |
| 217m         | Taquicardia ventricular | 0.00         | 0.00          | 3                 | 0     | 523   | 3     |
| 217m         | Otra Arritmia           | 46.31        | 58.71         | 1870              | 866   | 609   | 1004  |
| 219m         | Ritmo Sinusal Normal    | 3.27         | 6.28          | 459               | 15    | 224   | 444   |
| 219m         | Fibrilacion Auricular   | 9.93         | 71.60         | 1802              | 179   | 71    | 1623  |
| 219m         | Otra Arritmia           | 65.38        | 1.69          | 26                | 17    | 988   | 9     |
| 220m         | Ritmo Sinusal Normal    | 2.42         | 98.00         | 2024              | 49    | 1     | 1975  |
| 220m         | Otra Arritmia           | 0.00         | 0.00          | 28                | 0     | 449   | 28    |
| 221m         | Fibrilacion Auricular   | 6.08         | 96.64         | 2368              | 144   | 5     | 2224  |
| 221m         | Taquicardia ventricular | 50.00        | 0.34          | 6                 | 3     | 888   | 3     |
| 221m         | Otra Arritmia           | 47.69        | 3.13          | 65                | 31    | 960   | 34    |
| 222m         | Ritmo Sinusal Normal    | 7.24         | 78.90         | 1188              | 86    | 23    | 1102  |
| 222m         | Aleteo Auricular        | 21.85        | 16.51         | 746               | 163   | 824   | 583   |
| 222m         | Fibrilacion Auricular   | 19.68        | 7.86          | 188               | 37    | 434   | 151   |
| 222m         | Otra Arritmia           | 52.93        | 41.12         | 376               | 199   | 285   | 177   |
| 223m         | Ritmo Sinusal Normal    | 4.04         | 88.04         | 2003              | 81    | 11    | 1922  |
| 223m         | Taquicardia ventricular | 60.11        | 7.82          | 183               | 110   | 1297  | 73    |
| 223m         | Otra Arritmia           | 28.67        | 46.07         | 429               | 123   | 144   | 306   |
| 228m         | Ritmo Sinusal Normal    | 1.61         | 96.43         | 1681              | 27    | 1     | 1654  |
| 228m         | Otra Arritmia           | 55.53        | 43.42         | 416               | 231   | 301   | 185   |
| 230m         | Ritmo Sinusal Normal    | 62.00        | 98.70         | 1342              | 832   | 11    | 510   |
| 230m         | Otra Arritmia           | 50.38        | 78.84         | 917               | 462   | 124   | 455   |
| 231m         | Ritmo Sinusal Normal    | 96.44        | 66.15         | 758               | 731   | 374   | 27    |
| 231m         | Otra Arritmia           | 14.11        | 96.64         | 815               | 115   | 4     | 700   |
| 232m         | Bradicardia Sinusal     | 1.82         | 100.00        | 1815              | 33    | 0     | 1782  |
| 233m         | Ritmo Sinusal Normal    | 0.10         | 100.00        | 2873              | 3     | 0     | 2870  |
| 233m         | Taquicardia ventricular | 33.33        | 0.39          | 18                | 6     | 1540  | 12    |
| 233m         | Otra Arritmia           | 52.63        | 14.01         | 190               | 100   | 614   | 90    |
| 234m         | Ritmo Sinusal Normal    | 71.38        | 100.00        | 2711              | 1935  | 0     | 776   |
| 234m         | Otra Arritmia           | 2.00         | 20.00         | 50                | 1     | 4     | 49    |
| 48 registros |                         | 30.76        | 53.60         | 110253            | 33915 | 29357 | 76338 |

## Conclusiones

* Se implementó el algoritmo Pan Tompkins para hallar los picos R con una sensibilidad de 96.43% y predictividad de 96.36% sobre los 48 registros que proporciona la base de datos de arritmias del MIT-BIH 24H.
* Se implementó el algoritmo de Mohamed Elgendi para hallar las ondas P con una sensibilidad de 91.74% y predictividad de 81.76% sobre los 12 registros que proporciona la base de datos de arritmias del MIT-BIH 24H para las ondas P.
* Se implementó las reglas de decisión de Parayikorn para poder detectar las arritmias con una sensibilidad de 30.76% y predictividad de 53.60% sobre los 48 registros de la base de datos de arritmias del MIT-BIH 24H.
