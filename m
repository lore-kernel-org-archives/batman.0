Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 7 Aug 2014 10:37:36 +0200
References: <53E274D5.1070008@jluehr.de>
In-Reply-To: <53E274D5.1070008@jluehr.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201408071037.36351.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] alfred: IPC issues
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello Jan,

> Hei folks,
> 
> I'm using alfred 2014.0.0 on OpenWRT Barrier Breaker.
> 
> Alfred is running:
> root@6466b34ffcac:~# ps -w | grep alfred
>  1718 root      1100 S    /usr/sbin/alfred -i br-freifunk -b bat0
> 
> But cannot be queried using the client:
> root@6466b34ffcac:~# alfred -r 94
> can't connect to unix socket: Connection refused
> 
> What's wrong here?
> 
> Configuration is
> config 'alfred' 'alfred'
>   option interface 'br-freifunk'
>   option mode 'server'
>   option batmanif 'bat0'
>   option start_vis '0'
>   option run_facters '0'
> 

I don't see a problem right from your configuration. Can you please check:

 * do you see the socket file /var/run/alfred.sock after starting alfred? 
 * does the same problem happen if you restart alfred or start it manually?

Thank you,
    Simon
