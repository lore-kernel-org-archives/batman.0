From: elektra <onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] switching from 0.2
Date: Mon, 8 Oct 2007 12:52:06 +0200
References: <2bda28cd0710080329g4c21fe84va7afa2211841cec2@mail.gmail.com>
In-Reply-To: <2bda28cd0710080329g4c21fe84va7afa2211841cec2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710081252.06909.onelektra@gmx.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi -

you may need to change your firewall settings if you are running a firewall on 
your devices. We have new port numbers thanks to the IANA that has assigned 
port 4305 UDP to batman. We are also using port 4306 (UDP) for the gateway 
tunnels and 4307 to connect to the vis-server.

Apart from these changes the syntax hasn't changed much. Gateways can now 
configure the uplink/downlink speed.

If you are trying to use it today you may be disappointed since we are 
currently searching for a bug that is affecting link metrics.

As soon as we have this issue fixed we would be happy to hear about your 
results.

Cheers,

elektra

> There is a sort of HOWTO to switch from 0.2 release (compilation,
> configuration, new features) to 0.3?
> I'm interested to make a package for kamikaze svn version to test batman in
> a 30 mesh network (now we use batman 0.2).
>
> Thanks


