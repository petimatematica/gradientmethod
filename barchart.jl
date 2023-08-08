using Plots, StatsPlots

# Dados de exemplo
categorias = ["1.E-07", "1.E-08+(r/5)", "1.E-08+(r/10)", "1.E-08+(r/15)", "1.E-08"]
MGA5 = [1.0, 1.0, 0.99, 0.97, 0.62]
MGG5 = [0.96, 0.96, 0.96, 0.96, 0.8]
MGA20 = [1.0, 0.88, 0.13, 0.1, 0.0]
MGG20 = [1.0, 1.0, 1.0, 1.0, 0.62]

bar_colors = [:blue3 :green :royalblue1 :green2]

# Plotar o gráfico de colunas agrupadas
barchart = groupedbar(categorias, [MGA5 MGG5 MGA20 MGG20], bar_width=0.7,
xlabel="Values of ϵ (r=1.E-07-1.E-08)", ylabel="Solved problems [%]", legend=:bottomleft, 
label=["MGA (dim=5)" "MGG (dim=5)" "MGA (dim=20)" "MGG (dim=20)"], framestyle = :box, seriescolor=bar_colors)