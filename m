Return-Path: <viro@ftp.linux.org.uk>
Date: Wed, 18 Apr 2012 19:15:53 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120418181553.GG6589@ZenIV.linux.org.uk>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120418180837.GB6589@ZenIV.linux.org.uk>
	<20120418181150.GE6589@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120418181150.GE6589@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [B.A.T.M.A.N.] batman: keep batman_ogm_packet ->seqno
	net-endian all along
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net

grr... this one would be 3/4 and the last ("trivial endianness annotations") -
4/4.  My apologies...
