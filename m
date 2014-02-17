Return-Path: <trandatnh@gmail.com>
MIME-Version: 1.0
From: Le Tran Dat <trandatnh@gmail.com>
Date: Mon, 17 Feb 2014 17:24:04 +0800
Message-ID: <CAOyZXpRjy=e+Q-qq11YrkJJ=c1ni8CQVfmGepYEnKZ_TJda9Uw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [A.L.F.R.E.D] Can not get data from alfred client.
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
To: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

Hi list,

I have trouble with Alfred server and client. I have a Batman-adv
serve as a server and another as client.

In the server node (batman-adv server) I start alfred as master.
In the client node (batman-adv client) I start alfred as slave.

Then I try to set data from server node by command:
echo "data from server" | alfred -s 65
I can see the data in server side by command
alfred -r 65

But I can not read the data from client by using the same command.

How can I troubleshoot this issue since I have successfully set and
get data via alfred before. I have no ideas why it is not working now.

Thanks,
Dat
