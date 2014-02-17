Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 17 Feb 2014 12:50:09 +0100
References: <CAOyZXpRjy=e+Q-qq11YrkJJ=c1ni8CQVfmGepYEnKZ_TJda9Uw@mail.gmail.com>
In-Reply-To: <CAOyZXpRjy=e+Q-qq11YrkJJ=c1ni8CQVfmGepYEnKZ_TJda9Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402171250.09563.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [A.L.F.R.E.D] Can not get data from alfred
	client.
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

Hey Dat,

> Hi list,
> 
> I have trouble with Alfred server and client. I have a Batman-adv
> serve as a server and another as client.
> 
> In the server node (batman-adv server) I start alfred as master.
> In the client node (batman-adv client) I start alfred as slave.
> 
> Then I try to set data from server node by command:
> echo "data from server" | alfred -s 65
> I can see the data in server side by command
> alfred -r 65
> 
> But I can not read the data from client by using the same command.
> 
> How can I troubleshoot this issue since I have successfully set and
> get data via alfred before. I have no ideas why it is not working now.

is the underlying IPv6 connection working, e.g. can you ping6 the other node?

Does it work if you set both into master mode? You should wait 10 seconds 
before trying to read on the other node in this case.

Cheers,
    Simon
