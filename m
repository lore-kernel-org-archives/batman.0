Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 5 Dec 2016 13:06:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20161205100652.GA8244@mwanda>
References: <20161130195327.GA10274@mwanda>
 <1800526.pyWDsWJuoq@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1800526.pyWDsWJuoq@bentobox>
Subject: Re: [B.A.T.M.A.N.] [bug report] batman-adv: make the TT CRC logic
 VLAN specific
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

On Fri, Dec 02, 2016 at 05:34:39PM +0100, Sven Eckelmann wrote:
> On Mittwoch, 30. November 2016 22:53:27 CET Dan Carpenter wrote:
> > Hello Antonio Quartulli,
> > 
> > The patch 7ea7b4a14275: "batman-adv: make the TT CRC logic VLAN
> > specific" from Jul 30, 2013, leads to the following static checker
> > warning:
> [...]
> > 	net/batman-adv/translation-table.c:3313 batadv_send_my_tt_response()
> > 	error: uninitialized symbol 'tt_change'.
> 
> Thank you very much for your excellent report. Antonio seems to be busy
> at the moment but Simon already forwarded [1] your suggestion to David.
> 
> Small question - what static checker reported that? I would usually guess
> smatch when I see your name but at least it was not reproducible with the
> current smatch from http://repo.or.cz/w/smatch.git

It's some unreleased Smatch stuff I'm working on.  (Very buggy).

regards,
dan carpenter


