Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Thu, 4 Jun 2020 21:46:43 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v2] batctl: Add per interface hop penalty command
Message-ID: <20200604194643.GA2311@otheros>
References: <20200604194353.2656-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200604194353.2656-1-linus.luessing@c0d3.blue>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Jun 04, 2020 at 09:43:53PM +0200, Linus L=C3=BCssing wrote:
> This patch extends the hop penalty setting to be configurable not only
> on a node scope but also on a per hard interface basis.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  README.rst    |  7 ++++++-
>  event.c       |  4 ++++
>  hop_penalty.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  man/batctl.8  |  4 ++++
>  4 files changed, 61 insertions(+), 1 deletion(-)

Changelog v2:

* merged if_hop_penalty.c into hop_penalty.c (saved some duplicate
  code)
* added and tested hardif event monitor for the hop penalty
  attribute
