
def squared_distance(features, references):
    return sum(
        (feature - reference) ** 2
        for feature, reference in zip(features, references)
    )


def classify(distance, scale=1024, threshold=100):
    score = distance // scale
    return "ANOMALY" if score >= threshold else "NORMAL"


def main():
    reference = [100, 200, 300, 400]

    test_cases = [
        ("Normal sample", [102, 201, 299, 405], "NORMAL"),
        ("Anomaly sample", [500, 20, 800, 100], "ANOMALY"),
    ]

    for name, features, expected in test_cases:
        distance = squared_distance(features, reference)
        score = distance // 1024
        result = classify(distance)

        print(
            f"{name}: distance={distance}, "
            f"score={score}, result={result}"
        )

        assert result == expected, (
            f"{name}: expected {expected}, got {result}"
        )

    print("PASS: All distance classification tests passed.")


if __name__ == "__main__":
    main()
