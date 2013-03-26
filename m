Return-Path: <ajeetbbr@gmail.com>
MIME-Version: 1.0
Date: Tue, 26 Mar 2013 14:45:23 +0530
Message-ID: <CAHQ_bgjaBemwFJA4JH2c9+R9MS58BPAFt8z-6fEX5DOciYBsQQ@mail.gmail.com>
From: ajeet singh <ajeetbbr@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] MAC address for BAT0 Intefrace
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

Hello All,

I saw in the batman-adv code that random MAC address is being assigned
to BAT0 Interface.
I need some clarification regarding this.


I have tested the following tests,
Test Scenarios:
        Batman_Node_ A (192.0.0.1) ----------------------
Batman_Node_B (192.0.0.2)

Test 1: First, I used batman code without any change. I used
eth_hw_addr_random () for BAT0 MAC assignment.
    Result: I am able to ping from node A to Node B


Test 2: I commented =93eth_hw_addr_random ()=94 and assigned MAC address
of primary interface to BAT0 interface at both nodes. Now, we have
same MAC for primary interface and BAT0 at both nodes.
     Result: I am able to ping from node A to Node B

As you guys have assigned the random MAC to BAT0 interface, I wanted
to know that what would be potential problems if we assign the MAC
addresses of primary interface to the bat0 interface.


Thanks in advance.

Thanks
Ajeet
