import pandas
import matplotlib.pyplot as plt
import io

xls = None

def load_xls(path):
    global xls
    try:
        xls = pandas.read_excel(path).drop_duplicates().sort_values(by=['Miasto', 'Rok', 'Miesiąc'])
        return True
    except:
        return False

def get_cities():
    return list(xls['Miasto'].drop_duplicates().sort_values())

def get_years():
    return list(xls['Rok'].drop_duplicates().sort_values())

def get_months():
    return list(xls['Miesiąc'].drop_duplicates().sort_values())

def plot_city_year(city, year):
    to_plot = xls.query(f"Miasto == '{city}' and Rok == {year}")
    plt.figure(figsize=(12, 6))
    plt.xlabel('Miesiąc')
    plt.ylabel('Temperatura')
    plt.title(f'Temperatura w {city} w roku {year}')
    plt.plot(to_plot['Miesiąc'], to_plot['Temperatura'])
    plt.grid()
    buf = io.BytesIO()
    plt.savefig(buf, format='png')
    return list(buf.getvalue())

def plot_city_month(city, month):
    to_plot = xls.query(f"Miasto == '{city}' and Miesiąc == {month}")
    plt.figure(figsize=(12, 6))
    plt.xlabel('Rok')
    plt.ylabel('Temperatura')
    plt.title(f'Temperatura w {city} w miesiącu {month}')
    plt.plot(to_plot['Rok'], to_plot['Temperatura'])
    plt.grid()
    buf = io.BytesIO()
    plt.savefig(buf, format='png')
    return list(buf.getvalue())
