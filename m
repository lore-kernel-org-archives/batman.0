Return-Path: <andrew@lunn.ch>
Date: Thu, 22 Oct 2015 03:14:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20151022011404.GA1985@lunn.ch>
References: <CAKaWdxbrS90fbV4if4ZhRYtdL-neikMc4iVb_EtowJf8M=9dvg@mail.gmail.com>
 <20151022005325.GB930@lunn.ch>
 <CAKaWdxYsHwOGu6YXLr6APgwwBP-xdg3DmFD63z6ehj=sv4PCUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaWdxYsHwOGu6YXLr6APgwwBP-xdg3DmFD63z6ehj=sv4PCUw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Alfred GPS higher update rate
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

> This is not a problem, I can look into this. I am worried about the
> 5Hz update rate, would the alfred/batman network layer be able to
> handle the data.

It probably can. But you need to watch out for other services using
alfred. You probably don't want to be updating VIS data at 5Hz.

Also, you probably don't want to be sending announce master packets at
that rate.

  Andrew
