# Aplicación para la detección temprana de arritmias basado en los algoritmos de Pan & Tompkins, Elgendi y Boonperm

Las arritmias son anomalías en el correcto funcionamiento del sistema eléctrico del corazón. Las cuatro cámaras del corazón por lo general laten con un patrón estable y rítmico. La presencia de arritmias es peligrosa para quien las padece y de no ser tratadas a tiempo pueden devenir en enfermedades cardiovasculares que traerán consecuencias fatales y podrían producir la muerte. Para detectar arritmias cardiacas en forma temprana se suelen utilizar monitores de funciones vitales que son costosos, no son portables y cuyo software no es abierto. Ante este contexto se propone una aplicación para la detección de las arritmias: Bradicardia Sinusal, Taquicardia Ventricular, Fibrilación Auricular, Flutter Auricular y Aleteo Auricular, a partir de los algoritmos Pan y Tompkins, Elgendi y Boonperm cuyo código podría ser instalado en dispositivos móviles (Android y iOS) para que los monitores de funciones vitales no sean la única opción para poder detectar dichas arritmias. El algoritmo ensamblado ha sido probado con la base de datos de arritmias del MIT-BIH, primer conjunto de datos de prueba estándar disponible para el ámbito académico. Se analizaron los 48 registros de dicha base de datos y se obtuvo 30.76% de sensibilidad y 53.60% de predictividad en la detección de arritmias, a pesar de los valores obtenidos en la detección de los complejos QRS se obtuvo 96.43 sensibilidad y 96.37% predictividad, lo cual indica que el algoritmo híbrido es confiable solo para la detección de complejos QRS. 

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

**2. Elgendi, 2014** propuso un método basado en dos filtros de promedio móvil seguido de un umbral de duración de evento dinámico para detectar ondas P y T en señales electrocardiográficas. La detección de las ondas P y T es afectada por la calidad de las grabaciones de electrocardiogramas y las anormalidades de las señales electrocardiográficas. Dicho método detecta ondas P y T en señales electrocardiográficas de arritmias que sufren: 1) efectos no estacionarios, 2) baja relación señal / ruido, 3) Complejo auricular prematuro, 5) Bloques de rama izquierda y 6) Bloques de rama derecha. Cabe destacar que el detector de ondas P y T obtuvo una sensibilidad del 98.05 por ciento y una predictividad positiva del 97.11 por ciento para las ondas P sobre 10 registros de la base de datos de arritmia MIT-BIH con 21702 latidos

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

**3. Boonperm, 2014** et al. propone un programa con interfaz gráfica que detecta arritmias usando MATLAB con los parámetros de el complejo QRS, la onda P, intervalo RR, el intervalo PR, y el ritmo del ECG usando la base de datos de arritmias del MIT. 
