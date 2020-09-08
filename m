Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Alessandro Bolletta <abolletta@netter.io>
Date: Tue, 8 Sep 2020 13:23:32 +0200
Message-ID: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com>
Subject: Running multiple batman-adv namespaces on the same broadcast domain
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi everybody,

i'm trying to reproduce a PoC where i'm running multiple batman-adv
instances(eg. bat0, bat1, batX) on the same broadcast domain.

So the scenario is:

---

host 1, host 2, host 3 are connected through an ethernet switch,
leveraging on a single network card (eth0) each.

host 1 runs three batman-adv instances (bat0, bat1, bat2) and each of
these instances uses eth0 as member interface

Each batman-adv instance lives good on the respecting "namespace"
using the same broadcast domain to talk with neighbours.

---

Is this kind of scenario supported?

Thank you
