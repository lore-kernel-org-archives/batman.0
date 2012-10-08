Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
Date: Tue, 9 Oct 2012 00:10:56 +0200
Message-ID: <CA+h5VgoTV5mj++Lk74eVnZWkpdne9zmZMYNUbV5YXy1r_fYAhQ@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] adding mac address field to orig_node struct
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

Hi

[1] I am using batmand, I have added the following field to the
orig_node struct in batman.h:

char * mac_addr;

[2] In get_orig_node() in originator.c:

        orig_node->mac_addr = (char *)malloc(30 * sizeof(char));
        memset(orig_node->mac_addr, 0, 30);

[3] Problem: When I update this field in isbidirectional() in batman.c:

memcpy(orig_neigh_node->mac_addr, mac_addr_1, strlen(mac_addr_1));

it updates the field fine, but it does not persist, that is to say
that after receiving another OGM from the same station,
orig_neigh_node->mac_addr is empty. I dont understand why this should
be happening.

Thanks

Dominic
UCT, SA

-- 
If you are going to achieve excellence in big things, you develop the
habit in little matters. Excellence is not an exception, it is a
prevailing attitude.
Colin Powell
