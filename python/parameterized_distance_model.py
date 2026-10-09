
def squared_distance(features, references):
    if len(features) != len(references):
        raise ValueError("Feature and reference lengths must match")

    return sum(
        (feature - reference) ** 2
        for feature, reference in zip(features, references)
    )


def main():
    features = [102, 201, 299, 405]
    references = [100, 200, 300, 400]

    expected = squared_distance(features, references)
    print("Features:", features)
    print("References:", references)
    print("Expected squared distance:", expected)

    assert expected == 31, "Distance verification failed!"
    print("PASS: Python reference model verified.")


if __name__ == "__main__":
    main()
