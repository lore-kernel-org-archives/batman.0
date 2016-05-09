Return-Path: <andrew@lunn.ch>
Date: Mon, 9 May 2016 16:23:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160509142304.GA10508@lunn.ch>
References: <1462372207-28322-1-git-send-email-andrew@lunn.ch>
 <3082168.4WeLqNseqL@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3082168.4WeLqNseqL@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batctl: Use netlink to replace some of
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

> This is actually a report of a possible problem by Simon (I've only
> checked it):

Hi Sven, Simon

> It looks like the orig_iface handling isn't handled here (see
> handle_debug_table "case 'i'") or am I missing something?

Yes, the -i handling is missing. Also -m and -u for translocal and
transglobal.

I will fix this up.

  Andrew
