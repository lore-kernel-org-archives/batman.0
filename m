Return-Path: <andrew@lunn.ch>
Date: Thu, 3 Oct 2013 16:38:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131003143851.GE20056@lunn.ch>
References: <1380731152-17874-1-git-send-email-andrew@lunn.ch>
 <20131003142506.GD3588@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131003142506.GD3588@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv1] GPS distribution via Alfred
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Janne.Paatero@ruag.com, sven@open-mesh.com, siwu@hrz.tu-chmnitz.de

On Thu, Oct 03, 2013 at 04:25:07PM +0200, Simon Wunderlich wrote:
> On Wed, Oct 02, 2013 at 06:25:51PM +0200, Andrew Lunn wrote:
> > Hi Folks
> > 
> > I'm working on a mesh project with some nodes which are nomadic.  I
> > need to know the location of each node, so i can do map overlays. So
> > these nomadic nodes have GPS and i'm distributing the location
> > information over Alfred, with a new server/client binary. I also have
> > stationary nodes, and a simulation system, without GPS, so i have
> > support for passing location via the command line.
> > 
> > The code needs some more testing, a man page, but release early,
> > release often, so here it is. 
> > 
> > Comment welcome.
> > 
> > 	Andrew
> 
> Did you accidentlly send this E-mail a second time?

Yes. When sending the RFC patch, i went back in my bash history for
the git send-email command used previously, and accidentally sent the
cover note patch before i noticed my error.

      Andrew
