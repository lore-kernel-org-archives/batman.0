Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 20 Sep 2016 16:29:02 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160920142902.GB7375@otheros>
References: <35819279.yt4EnXKmx6@bentobox>
 <1468423822-28324-1-git-send-email-sven@narfation.org>
 <1468423822-28324-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468423822-28324-5-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batctl: Allow to disable automatic
 interface new/destroy
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jul 13, 2016 at 05:30:20PM +0200, Sven Eckelmann wrote:
> Users may not want to lose their configured batman-adv soft-interface when
> they remove a single interface from it. The default configuration may not
> working well enough in the network setup of the user and thus it should be
> possible to avoid that it gets reset to it when a new interface is added
> after the last one was removed.
> 
> This can be done by avoiding automatic creation of an interface when the
> command "add" is used together with the option "-M". The add would fail
> when the soft-interface disappeared for some reason and thus the
> soft-interface would not be created again with the default configuration.
> But more importantly, the "del" command can be informed with the option
> "-M" to not try to remove the soft-interface in the first place.

Currently wondering... have you thought about maybe
memorizing when a batman-adv interface was created via the new
"new" command? And in that case then transparently avoiding the automatic
destruction.

Would be one less parameter to memorize for the user then.
