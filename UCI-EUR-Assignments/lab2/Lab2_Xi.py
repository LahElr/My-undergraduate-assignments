import pandas
import numpy

data = pandas.read_csv("./Cereals.csv")  # read in

# drop rows with missing values and show info
print(data.shape, end="")
data_d = data.dropna(axis=0, how='any', inplace=False)
print(" -> {}".format(data_d.shape))

data_full = data
data = data_d
del data_d

# numeralization & scale
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import MinMaxScaler

# use label encoder to numeralizaion
label_encoder = LabelEncoder()
for col in data.columns:
    if data[col].dtype == "object":
        data[col] = label_encoder.fit_transform(data[col])
# use min max scaler to scale
scaler = MinMaxScaler()
data = scaler.fit_transform(data)

# function to visualize
from sklearn.manifold import TSNE
import matplotlib.pyplot as plt


def show_data(data, labels=None, name=None, centers=None):
    tsne = TSNE(n_components=2, init='pca', random_state=501)  # dim-reducer

    if centers is not None:
        # addition points must be concatenated to data due to TSNE has no transform function
        data_center = numpy.concatenate((data, centers), axis=0)
        data_center = tsne.fit_transform(data_center)
        data_tsne = data_center[:data.shape[0]]
        centers = data_center[data.shape[0]:]
    else:
        data_tsne = tsne.fit_transform(data)

    print(
        "t-SNE report: data dimension has been reduced from {} to {}.".format(
            data.shape[-1], data_tsne.shape[-1]))  # summary info

    # plot
    plt.figure(figsize=(6, 6))
    # data points
    for i in range(data_tsne.shape[0]):
        plt.plot(data_tsne[i, 0],
                 data_tsne[i, 1],
                 "o",
                 color="blue" if labels is None else plt.cm.Set1(labels[i]))
    # additional points
    if centers is not None:
        for i in range(centers.shape[0]):
            plt.plot(centers[i, 0],
                     centers[i, 1],
                     "+",
                     color="blue" if labels is None else plt.cm.Set1(i))
    # title
    if name is not None:
        plt.title(name)
    plt.tight_layout()
    plt.savefig(
        "figs/{}.png".format(name if name is not None else "fig"))  # save
    plt.show()


# see original data
show_data(data, name="origin data")

# hierarchy cluster
from scipy.cluster.hierarchy import linkage, dendrogram, centroid

# linkage
for method in ["ward", "single", "complete"]:
    plt.figure(figsize=(20, 6))
    Z = linkage(data, method=method, metric='euclidean')  # do clustering
    p = dendrogram(Z, 0)  # visulization
    plt.title("dendrogram of {} linkage".format(method))
    plt.savefig("figs/dendrogram of {} linkage.png".format(method))
    plt.show()

# centroid
plt.figure(figsize=(20, 6))
Z = centroid(data)  # do clustering
p = dendrogram(Z, 0)  # visulization
plt.title("dendrogram of centroid")
plt.savefig("figs/dendrogram of centroid.png")
plt.show()

# agglomerative
from sklearn.cluster import AgglomerativeClustering

for linkage in ["ward", "single", "complete"]:
    agg = AgglomerativeClustering(n_clusters=4,
                                  affinity="euclidean",
                                  linkage=linkage)
    labels = agg.fit_predict(data)
    print(labels)
    # show clustered data with centers of clusters
    # here I use mean value as the center of a cluster
    # the long list generator finds points within cluster, and calculate their mean value for all clusters
    show_data(
        data, labels,
        "agg cluster with centers, linkage method {}".format(linkage),
        numpy.concatenate([
            numpy.mean(points, axis=0) for points in
            [[data[ind] for ind in numpy.argwhere(labels == cluster)]
             for cluster in range(max(labels) + 1)]
        ],
                          axis=0))

    # As the additional points could inference the dim-reduction of t-SNE,
    # here I plot a pic without center points as a comparsion
    show_data(data, labels,
              "agg cluster without centers, linkage method {}".format(linkage))
