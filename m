Return-Path: <linus.luessing@web.de>
Date: Wed, 13 Jan 2010 02:30:37 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100113013037.GA10176@Sellars>
References: <20091231033752.GA18781@Sellars>
	<1263185876-24214-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1263185876-24214-1-git-send-email-linus.luessing@web.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: atomic variable for vis-srv
	activation
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
To: b.a.t.m.a.n@lists.open-mesh.net

I now decided to use a more general variable name and as Marek
suggested the checks against the given define-values. This should
keep the structure of several "vis-modes" in general, as it had
been done before by Simon, instead of just "on" and "off".

The checkpatch-script from the batman-adv linux git branch showed
me 0 errors/warnings for this one.

- So far, just had the time to test this patch with my laptop and
  home-server only. But switching as well as receiving/displaying
  the vis-stuff worked fine for those (didn't have a closer look
  with tcpdump/wireshark for this vis-type part though).

Cheers, Linus
