Return-Path: <johannes.berg@intel.com>
From: "Berg, Johannes" <johannes.berg@intel.com>
Date: Fri, 25 Jan 2019 08:16:46 +0000
Message-ID: <1DC40B07CD6EC041A66726C271A73AE68CFA842A@IRSMSX108.ger.corp.intel.com>
References: <20190125080205.10594-1-sven@narfation.org>
In-Reply-To: <20190125080205.10594-1-sven@narfation.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: release station info
 tidstats
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Felix Fietkau <nbd@nbd.name>, Arend van Spriel <aspriel@gmail.com>

Huh, sorry about that.

> From: Felix Fietkau <nbd@nbd.name>

If Felix had nothing to do with the patch, why would you pretend otherwise?

You need two patches - one for backports, this part:

>  compat-include/net/cfg80211.h | 7 +++++++

And for mainline, this part:

>  net/batman-adv/bat_v_elp.c    | 3 +++

So send the two separate patches to the two separate projects, and that's i=
t?

johannes
-- =

 =

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

