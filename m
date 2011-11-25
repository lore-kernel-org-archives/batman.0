Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 25 Nov 2011 13:27:14 +0800
References: <1322139961-12706-1-git-send-email-daniele.furlan@gmail.com>
	<3164615.DFmizAk306@sven-laptop.home.narfation.org>
	<CAG7VhQSLjXX_FKSwYpHRQCqC2ro28JWMqFn4kgJ4TL5APqWqng@mail.gmail.com>
In-Reply-To: <CAG7VhQSLjXX_FKSwYpHRQCqC2ro28JWMqFn4kgJ4TL5APqWqng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111251327.15188.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Remove useless condition
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

On Thursday, November 24, 2011 22:56:48 Daniele Furlan wrote:
> > Wrong proof using wrong assumptions. You just cannot say that
> > TQ_LOCAL_BIDRECT_SEND_MINIMUM has always the same value as
> > TQ_LOCAL_BIDRECT_RECV_MINIMUM just because it is in this particular
> > example.
> 
> Anyhow, is there a reason to assign to these constants different values?

Well, one is the minimum for the RQ and the other one for the EQ. There could 
be several reasons to have different values here (depending on your needs).

Cheers,
Marek
