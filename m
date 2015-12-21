Return-Path: <trizonelabs@gmail.com>
MIME-Version: 1.0
Date: Mon, 21 Dec 2015 15:47:56 +0200
Message-ID: <CAJuY50w0AChCgoqW1qTtF0rCLGNefXpcg36Niw3xfXHSbf5yJQ@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] alfred dies without log-entries
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

ref: alfred ver 2015.1 / .2

alfred process dies (not in ps ) without leaving any log entry for reason why

alfred -r 64 :  can't connect to unix socket : Connetion refused

remains : /tmp/run/
   alfred.pid
   alfred.sock

batadv-vis still in process-list and shows data

alfred stop  does not  kill the remains
start / restart / reload does not bring alfred up

system reboot required

occurence : frequent irregular at start or after some time

afred.facters disabled

does anybody have any hint or idea ?

cheers
3zl
