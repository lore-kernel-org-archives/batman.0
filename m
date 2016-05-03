Return-Path: <andrew@lunn.ch>
Date: Tue, 3 May 2016 14:47:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160503124719.GB16952@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
 <3295917.zMxpBmcd5T@bentobox> <20160503122046.GK16990@lunn.ch>
 <1679465.5nkEMONaEr@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679465.5nkEMONaEr@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
 debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Tue, May 03, 2016 at 02:26:34PM +0200, Sven Eckelmann wrote:
> On Tuesday 03 May 2016 14:20:46 Andrew Lunn wrote:
> [...]
> > There does not seem to be a way to say that BATADV_ATTR_VERSION is
> > also an NLA_STRING.
> 
> Please check "policy" in the link I gave you.

I did. And i still don't get how you can check the type.

  Andrew
