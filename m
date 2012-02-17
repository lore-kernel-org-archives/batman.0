Return-Path: <broonie@sirena.org.uk>
Date: Fri, 17 Feb 2012 21:01:48 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Message-ID: <20120217210148.GA9935@sirena.org.uk>
References: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
	<20120217.152323.2251437927591117547.davem@davemloft.net>
	<1990573.JisbTKXt7B@sven-laptop.home.narfation.org>
	<20120217.155049.1321221133602638857.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120217.155049.1321221133602638857.davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-02-17
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

On Fri, Feb 17, 2012 at 03:50:49PM -0500, David Miller wrote:

> I'm reluctant to pull tags which are signed, I certainly don't have
> your personal keys in my key ring for example.  And distributions
> ship with GIT versions that don't support signed tags, so...

The signed tags interoperate fine with old versions, you won't be able
to validate them but they shouldn't cause any hassle.  If the key can't
be verified then that might be more of an issue but if you're OK with
pulling something that's completely unsigned you're not loosing
anything, it'll just record the signature.
