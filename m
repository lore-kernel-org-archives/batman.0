Return-Path: <andrew@lunn.ch>
Date: Mon, 16 May 2016 22:06:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160516200637.GB3738@lunn.ch>
References: <1463419689-3580-1-git-send-email-andrew@lunn.ch>
 <33261549.crZoJBqqoP@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33261549.crZoJBqqoP@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 00/11] netns and netlink support
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

On Mon, May 16, 2016 at 08:58:13PM +0200, Sven Eckelmann wrote:
> On Monday 16 May 2016 19:27:58 Andrew Lunn wrote:
> > * No change to code indentation. I consider it a false positive. The
> >   code is more readable the way it is, checkpatch is happy, and it
> >   does not violate anything in CodingStyle, as far as i can see.
> 
> @Antonio, @Marek, @Simon: Do you want to allow free-form alignments like this?
> 
> 			if (batadv_iv_ogm_neigh_dump_hardif(
> 				    msg, portid, cb->nlh->nlmsg_seq,
> 				    bat_priv, hard_iface, &idx)) {
> 				i_hardif--;
> 				break;
> 			}

It is not fully free-form, however i cannot tell you exactly where it
comes from. If you have emacs do auto indent, using the linux kernel
indentation style, that is where emacs puts it.

	    Andrew
