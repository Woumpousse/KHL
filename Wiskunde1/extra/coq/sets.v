Require Import Classical.


Definition Ensemble (A : Set) := A -> Prop.

Definition element {A : Set} (x : A) (X : Ensemble A) : Prop := X x.

Definition union {A : Set} (X Y : Ensemble A) : Ensemble A :=
  fun x : A => element x X \/ element x Y.

Definition intersection {A : Set} (X Y : Ensemble A) : Ensemble A :=
  fun x : A => element x X /\ element x Y.

Definition equal {A : Set} (X Y : Ensemble A) : Prop :=
  forall x : A, element x X <-> element x Y.


Theorem distributivity_intersection_union :
  forall {A : Set} (X Y Z : Ensemble A),
    equal (intersection X (union Y Z))
          (union (intersection X Y) (intersection X Z)).
Proof with auto.
  intros A X Y Z x.
  split; intros; compute in * |- *.
  destruct H as [H H0]; destruct H0...
  split; destruct H; destruct H...
Qed.

Theorem distributivity_union_intersection :
  forall {A : Set} (X Y Z : Ensemble A),
    equal (union X (intersection Y Z))
          (intersection (union X Y) (union X Z)).
Proof with auto.
  intros A X Y Z x.
  split; intros; compute in * |- *.
  destruct H...
  destruct H...
  destruct H as [H1 H2]; destruct H1; destruct H2...
Qed.
