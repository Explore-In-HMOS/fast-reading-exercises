@Observed
export class LetterCell {
  letter: string = '';
  isVisible: boolean = true;
  isFound: boolean = false;
  id: number = 0;
  effect: 'none' | 'success' | 'fail' | 'shine' = 'none';
  shake: number = 0;

  constructor(
    letter?: string,
    isVisible?: boolean,
    isFound?: boolean,
    id?: number,
    effect?: 'none' | 'success' | 'fail' | 'shine',
    shake?: number
  ) {
    if (letter !== undefined) {
      this.letter = letter;
    }
    if (isVisible !== undefined) {
      this.isVisible = isVisible;
    }
    if (isFound !== undefined) {
      this.isFound = isFound;
    }
    if (id !== undefined) {
      this.id = id;
    }
    if (effect !== undefined) {
      this.effect = effect;
    }
    if (shake !== undefined) {
      this.shake = shake;
    }
  }

  clone(): LetterCell {
    return new LetterCell(
      this.letter,
      this.isVisible,
      this.isFound,
      this.id,
      this.effect,
      this.shake
    );
  }

  update(
    letter?: string,
    isVisible?: boolean,
    isFound?: boolean,
    id?: number,
    effect?: 'none' | 'success' | 'fail' | 'shine',
    shake?: number
  ): LetterCell {
    const newCell = this.clone();
    if (letter !== undefined) {
      newCell.letter = letter;
    }
    if (isVisible !== undefined) {
      newCell.isVisible = isVisible;
    }
    if (isFound !== undefined) {
      newCell.isFound = isFound;
    }
    if (id !== undefined) {
      newCell.id = id;
    }
    if (effect !== undefined) {
      newCell.effect = effect;
    }
    if (shake !== undefined) {
      newCell.shake = shake;
    }
    return newCell;
  }
}

export function getCellBackgroundColor(cell: LetterCell): string {
  if (cell.effect === 'shine') {
    return '#fff3e0';
  }
  if (cell.effect === 'success' || cell.isFound) {
    return '#e8f5e8';
  }
  if (cell.effect === 'fail') {
    return '#ffebee';
  }
  if (cell.isVisible) {
    return '#ffffff';
  }
  return '#f0f0f0';
}

export function getCellBorderColor(cell: LetterCell): string {
  if (cell.effect === 'shine') {
    return '#ff9800';
  }
  if (cell.effect === 'success' || cell.isFound) {
    return '#4caf50';
  }
  if (cell.effect === 'fail') {
    return '#f44336';
  }
  if (cell.isVisible) {
    return '#ddd';
  }
  return '#f0f0f0';
}