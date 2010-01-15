Return-Path: <andrew@lunn.ch>
Date: Fri, 15 Jan 2010 19:50:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100115185008.GG24649@lunn.ch>
References: <20091231033752.GA18781@Sellars>
	<1263185876-24214-1-git-send-email-linus.luessing@web.de>
	<201001151124.25877.lindner_marek@yahoo.de>
	<201001151934.41937.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001151934.41937.sven.eckelmann@gmx.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net, Linus@open-mesh.net

On Fri, Jan 15, 2010 at 07:34:38PM +0100, Sven Eckelmann wrote:
> Marek Lindner wrote:
> > On Monday 11 January 2010 12:57:56 you wrote:
> > > This fixes the bug discovered by Marek Lindner which did not allow
> > > turning on the vis-server before an interface has been added. With this
> > > patch we are using a global atomic variable for activating and
> > > deactiating the vis-server-mode instead, which can be used before
> > > inserting an interface.
> > 
> > Off-list:
> > Wollte mir grad deinen Patch reinziehen, aber trotz "git send-email" ist
> >  auch diese Mail is base64 encoded ?? Im Header sehe ich jedenfalls
> >  "X-Mailer: git- send-email 1.6.6". Evtl. h?ngt das mit charset (utf8)
> >  zusammen ?
> 
> Aaaalso. Ich habe ersteinmal keine Ahnung woher es kommt. git-format-patch
> produziert sowas jedenfalls nicht. git-send-email eigentlich auch nicht (der 
> bleibt immer bei "Content-Type: text/plain; ...". Wenn ich jetzt im Git 
> Quellcode suche, dann finde ich auch nur funktionen um base64 in Mails zu 
> dekodieren.

All the patches i've generated so far from git have been plain old
ASCII, even though some contain extended characters, because of
umlauts in names. So i agree with Sven, it is more likely to be a
problem with the mail system somewhere, not git.

	Andrew
