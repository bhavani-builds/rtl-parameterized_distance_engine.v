
import csv
from pathlib import Path


def main():
    csv_path = (
        Path(__file__).resolve().parent.parent
        / "test_vectors"
        / "distance_test_vectors.csv"
    )

    if not csv_path.exists():
        raise FileNotFoundError(f"Test vectors not found: {csv_path}")

    count = 0

    with csv_path.open(newline="", encoding="utf-8") as file:
        for row in csv.DictReader(file):
            features = [
                int(row[f"feature_{i}"]) for i in range(4)
            ]
            references = [
                int(row[f"ref_{i}"]) for i in range(4)
            ]

            expected = int(row["expected_distance"])
            calculated = sum(
                (x - r) ** 2
                for x, r in zip(features, references)
            )

            if calculated != expected:
                raise AssertionError(
                    f'{row["test_name"]}: expected {expected}, '
                    f'calculated {calculated}'
                )

            print(f'PASS: {row["test_name"]} = {calculated}')
            count += 1

    if count == 0:
        raise AssertionError("No test vectors found")

    print(f"All {count} distance vectors verified.")


if __name__ == "__main__":
    main()
