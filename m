Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 23 Nov 2010 00:44:57 +0100
References: <1290462354-17246-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1290462354-17246-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201011230044.58352.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Fix bisecting of OGMs with
	32bit seqno
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday 22 November 2010 22:45:53 Linus L=C3=BCssing wrote:
> -static int seqno_event_new(char *iface_addr, char *orig, char
> *prev_sender, char *neigh, int seqno, int tq, int ttl) +static int
> seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char
> *neigh, int64_t seqno, int tq, int ttl)

Didn't you forget to adjust the seqno size in the seqno_event and seqno_tra=
ce=20
struct ? Simply declaring it 64bit in the function header won't do much goo=
d=20
=2E..

Regards,
Marek
